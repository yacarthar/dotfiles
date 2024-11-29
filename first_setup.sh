#!/usr/bin/bash

function initialize {
  sudo apt update
  sudo apt install -y curl git vim tmux

  mkdir ~/docs ~/ds
  # private ssh key
  curl -L -o ~/ds/yacarthar-git.pem https://www.dropbox.com/scl/fi/73riiml48ef809jipn9mm/yacarthar-git.pem?rlkey=d66lo1jtbp82wahd5dxi3wgpr&st=8bwa2a77&dl=1
  [ -d ~/.ssh ] || mkdir -p ~/.ssh && echo "Folder exists or has been created"
  mv ~/ds/yacarthar-git.pem ~/.ssh/yacarthar-git.pem
  chmod 600 ~/.ssh/yacarthar-git.pem

  # dotfiles
  git clone --config core.sshCommand="ssh -i ~/.ssh/yacarthar-git.pem" git@github.com:yacarthar/dotfiles.git ~/docs/dotfiles
  cd ~/docs/dotfiles
  chmod 775 ./install
  sudo ./install

  # ssh
  ssh-keygen -t rsa -f ~/.ssh/"$(whoami)-$(hostname)" -C "$(whoami)" -N ""
  mv ~/.ssh/"$(whoami)-$(hostname)".pub ~/.ssh/authorized_keys


  
function terminal_extra {
  # ag
  sudo apt install -y silversearcher-ag
}


function terminal_helpful {
  # howdoi
  pip install git+https://github.com/gleitz/howdoi.git#egg=howdoi

  # translate tool
  git clone https://github.com/soimort/translate-shell
  cd translate-shell/
  make
  sudo make install
}

not_cool_enough
./install
