sudo docker run -it --rm -p 2222:22 -e SSH_PUBLIC_KEYS="$(cat ~/.ssh/id_rsa.pub)\n$(cat ~/.ssh/ssh_keys/id_rsa.pub)\n$(cat ~/.ssh/ssh_keys/tnb.pub)" peru/ubuntu_sshd
