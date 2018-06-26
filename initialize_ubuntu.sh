install_zsh() {
    ZSH_R=$(cat /etc/shells | grep zsh)
    if [ -z "$ZSH_R" ]; then
        sudo apt install -y zsh
        chsh -s /bin/zsh
    fi
}

install_oh_my_zsh() {
    if [ ! -f ~/.zshrc ]; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
        sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/g' ~/.zshrc
        echo 'export GOPATH=~/go' >> ~/.zshrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.zshrc
    fi
    source ~/.zshrc
}

install_vimrc() {
    if [ ! -d ~/z/vimrc ]; then
        mkdir -p ~/z
        cd ~/z
        git clone https://github.com/YuanZhewei/vimrc.git
        cd vimrc
        sh install.sh
    fi
}

install_apt() {
    sudo apt install -y $1
}

install_apt openssh-server
install_opt lrzsz
install_apt git
install_apt cmake
install_apt python
install_apt python-dev
install_apt ddd

install_zsh
install_oh_my_zsh
install_vimrc
