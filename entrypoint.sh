#!/bin/bash -e

[ "$DEBUG" == 'true' ] && set -x

DAEMON=sshd

print_fingerprints() {
    local BASE_DIR=${1-'/etc/ssh'}
    for item in dsa rsa ecdsa ed25519; do
        echo "*** Fingerprints for ${item} host key"
        ssh-keygen -E md5 -lf ${BASE_DIR}/ssh_host_${item}_key 
        ssh-keygen -E sha256 -lf ${BASE_DIR}/ssh_host_${item}_key
        ssh-keygen -E sha512 -lf ${BASE_DIR}/ssh_host_${item}_key
    done
}


echo "*** Generating new host keys"
mkdir -p /etc/ssh
ssh-keygen -A
print_fingerprints /etc/ssh

echo "*** Creating ~/.ssh/authorized_keys"
install -d -m 0700 ~/.ssh
echo -e "$SSH_PUBLIC_KEYS" > ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

echo "*** Changing  /etc/ssh/sshd_config if necessary"
if [ "x$SSHD_PORT" != "x" ]; then
  echo "Port $SSHD_PORT" >> /etc/ssh/sshd_config
fi


stop() {
    echo "*** Received SIGINT or SIGTERM. Shutting down $DAEMON"
    # Get PID
    pid=$(cat /var/run/$DAEMON/$DAEMON.pid)
    # Set TERM
    kill -SIGTERM "${pid}"
    # Wait for exit
    wait "${pid}"
    # All done.
    echo "*** Done"
}

echo "*** Running: $@"
if [ "$(basename $1)" == "$DAEMON" ]; then
    trap stop SIGINT SIGTERM
    $@ &
    pid="$!"
    mkdir -p /var/run/$DAEMON && echo "${pid}" > /var/run/$DAEMON/$DAEMON.pid
    wait "${pid}" && exit $?
else
    exec "$@"
fi
