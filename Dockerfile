FROM ubuntu:latest
LABEL MAINTAINER="Petr Ruzicka <petr.ruzicka@gmail.com>"

RUN apt-get update \
    && apt-get install --no-install-recommends -y openssh-server rsync \
    && apt-get clean

COPY entrypoint.sh /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]

# do not detach (-D), log to stderr (-e)
CMD ["/usr/sbin/sshd", "-e", "-D", "-f", "/etc/ssh/sshd_config"]
