[![Docker pulls](https://img.shields.io/docker/pulls/peru/ubuntu_sshd.svg)](https://hub.docker.com/r/peru/ubuntu_sshd/)
[![Docker Build](https://img.shields.io/docker/automated/peru/ubuntu_sshd.svg)](https://hub.docker.com/r/peru/ubuntu_sshd/)

# Ubuntu Docker image running SSHd daemon

SSH server running on Ubuntu inside Docker. [Docker Hub page](https://hub.docker.com/r/peru/ubuntu_sshd/).


## Description

Latest Ubuntu LTS running SSH daemon inside.


## Usage:

`docker run -d -e SSH_PUBLIC_KEYS="<key>" peru/ubuntu_sshd`

or

`docker run -d -e SSHD_PORT="22" -e SSH_PUBLIC_KEYS="<key1>\n<key2>\n<key3>..." peru/ubuntu_sshd`


## Example:

```shell
docker run -it --rm -p 2222:22 -e SSH_PUBLIC_KEYS="$(cat ~/.ssh/id_rsa.pub)\n$(cat ~/.ssh/ssh_keys/id_rsa.pub)\n$(cat ~/.ssh/ssh_keys/my.pub)" peru/ubuntu_sshd
```

or

```shell
PUBLIC_KEY=`cat ~/.ssh/id_rsa.pub`
docker run -it --rm -p 2222:22 -e SSH_PUBLIC_KEYS="$PUBLIC_KEY" peru/ubuntu_sshd
```

After that, run `ssh root@127.0.0.1 -p 2222` to access it.  

## License
[MIT-LICENSE](MIT-LICENSE)

Thanks to [panubo/docker-sshd](https://github.com/panubo/docker-sshd)
