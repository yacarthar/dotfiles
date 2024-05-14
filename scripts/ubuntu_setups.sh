#!/usr/bin/bash

function initialize {
  sudo apt update
  sudo apt install -y curl git

  # curl
  if ! which curl >/dev/null 2>&1; then
      echo "curl is not installed. Installing..."
      sudo apt install -y curl
      echo "curl has been installed."
  else
      echo "curl is already installed."
  fi
  # git
  if ! which git >/dev/null 2>&1; then
      echo "git is not installed. Installing..."
      sudo apt install -y git
      echo "git has been installed."
  else
      echo "git is already installed."
  fi
}


function terminal_core {
  # vim
  if ! which vim >/dev/null 2>&1; then
      echo "vim is not installed. Installing..."
      sudo apt install -y vim
      echo "vim has been installed."
  else
      echo "vim is already installed."
  fi
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # tmux
  if ! which tmux >/dev/null 2>&1; then
      echo "tmux is not installed. Installing..."
      sudo apt install -y tmux
      echo "tmux has been installed."
  else
      echo "tmux is already installed."
  fi

  # xclip
  if ! which xclip >/dev/null 2>&1; then
      echo "xclip is not installed. Installing..."
      sudo apt install -y xclip
      echo "xclip has been installed."
  else
      echo "xclip is already installed."
  fi
}


function terminal_extra {
  # ag
  sudo apt install -y silversearcher-ag
  # ripgrep
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb
  sudo dpkg -i ripgrep_11.0.1_amd64.deb
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

function docker {
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; \
    do sudo apt-get remove $pkg; done

  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install -y ca-certificates
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo apt-get install docker-compose-plugin
  sudo usermod -aG docker $USER
}


function dev_tools {
  # Docker
  echo "Install docker and docker-compose"
  wget -qO- https://get.docker.com/ | sh
  COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
  sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
  sudo chmod +x /usr/local/bin/docker-compose
  sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
  sudo usermod -aG docker $USER

  # awscli
  sudo pip3 install awscli

  # install yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update && sudo apt install yarn
}

function not_cool_enough {
  # zsh
  echo "Installing zsh and oh-my-zsh..."
  sudo apt install -y zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sudo chsh -s /usr/bin/zsh
  git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  # tmux-vim-select-pane
  sudo curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane \
    -o /usr/local/bin/tmux-vim-select-pane
  sudo chmod +x /usr/local/bin/tmux-vim-select-pane
  # tmux plugin
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh

  # autojump: j for cd
  sudo apt install -y autojump
  # climate, a set of small tools
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/adtac/climate/master/install)"

  sudo apt install -y i3 # screen
  sudo apt install -y irssi # irc channel
  sudo apt install -y guake # just open terminal faster
  sudo apt install -y xpad # just a sticky note
  sudo apt install -y ncdu # alternative for du command

  # install FZF
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # install thefuck
  sudo apt install python3-dev python3-pip python3-setuptools
  sudo pip3 install thefuck

  # install fd
  curl -LO https://github.com/sharkdp/fd/releases/download/v7.3.0/fd-musl_7.3.0_amd64.deb
  sudo dpkg -i fd-musl_7.3.0_amd64.deb

  # install pyenv and virtualenv
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

  # install up
  curl -LO https://up.apex.sh/install ~/Desktop/install
  chmod +x ~/Desktop/install
  sudo ~/Desktop/install

  # GRV for viewing git project
  wget -O grv https://github.com/rgburke/grv/releases/download/v0.1.1/grv_v0.1.1_linux64
  chmod +x ./grv
}


initialize
terminal_core
terminal_extra
terminal_helpful
docker
# dev_tools
# not_cool_enough
./install
