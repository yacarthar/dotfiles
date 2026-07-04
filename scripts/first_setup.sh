#!/usr/bin/bash


# ---------------------------
# prepare favorite folder name
mkdir ~/docs ~/ds


# -------------------------

# private ssh key
curl -L -o ~/ds/yacarthar-git.pem https://www.dropbox.com/scl/fi/73riiml48ef809jipn9mm/yacarthar-git.pem?rlkey=d66lo1jtbp82wahd5dxi3wgpr&st=8bwa2a77&dl=1
[ -d ~/.ssh ] || mkdir -p ~/.ssh && echo "Folder exists or has been created"
mv ~/ds/yacarthar-git.pem ~/.ssh/yacarthar-git.pem
chmod 600 ~/.ssh/yacarthar-git.pem

# dotfiles
git clone --config core.sshCommand="ssh -i ~/.ssh/yacarthar-git.pem" git@github.com:yacarthar/dotfiles.git ~/ds/dotfiles
cd ~/ds/dotfiles
chmod 775 ./install
./install

# can access dropbox but can't access github



# create key to allow ssh
# ssh-keygen -t rsa -f ~/.ssh/"$(whoami)-$(hostname)" -C "$(whoami)" -N ""
# mv ~/.ssh/"$(whoami)-$(hostname)".pub ~/.ssh/authorized_keys





