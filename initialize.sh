install_brew() {
    brew --version >/dev/null
    if [ $? -ne 0 ]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_git() {
    git version >/dev/null
    if [ $? -ne 0 ]; then
        brew install git
    fi
    git config --global user.email "yuenzhewei@gmail.com"
    git config --global user.email "YUANZHEWEI"
}

install_zsh() {
    ZSH=$(cat /etc/shells | grep zsh)
    if [ -z "$ZSH" ]; then
        brew install zsh
        chsh -s /bin/zsh
    fi
}

install_oh_my_zsh() {
    if [ ! -f ~/.zshrc ]; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
        sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/g' ~/.zshrc
        echo 'export GOPATH=~/go' >> ~/.zshrc
        echo 'export PATH=/Applications/MacVim.app/Contents/bin:$PATH' >> ~/.zshrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.zshrc
    fi
    source ~/.zshrc
}

install_vimrc() {
    mkdir -p ~/z
    cd ~/z
    git clone https://github.com/YuanZhewei/vimrc.git
    cd vimrc
    sh install.sh
}

install_brew

install_git

install_zsh

install_oh_my_zsh

install_vimrc

#todo install dmg
#todo get lastest macvim
