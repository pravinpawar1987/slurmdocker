mkdir -p ~/.ssh
chmod 0700 ~/.ssh
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N "" -C "$(whoami)@$(hostname)-$(date -I)"
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 0640 ~/.ssh/authorized_keys
cat >> ~/.ssh/config <<EOF
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  LogLevel QUIET
EOF
chmod 0644 ~/.ssh/config
cd ~/
tar -czvf ~/worker-secret.tar.gz .ssh
cd -
