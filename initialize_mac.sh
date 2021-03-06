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
        git config --global user.email "yuenzhewei@gmail.com"
        git config --global user.email "YUANZHEWEI"
    fi
}

install_zsh() {
    ZSH_R=$(cat /etc/shells | grep zsh)
    if [ -z "$ZSH_R" ]; then
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
        echo "alias proxy='export all_proxy=socks5://127.0.0.1:1080'" >> ~/.zshrc
        echo "alias unproxy='unset all_proxy'" >> ~/.zshrc
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

check_and_cask_install() {
    if [ ! -d "$1" ]; then
        brew cask install $2
    fi
}

install_console_software() {
    brew install wget
    brew install tree
    brew install global
    brew install cloc
    brew install lrzsz
}

install_cask_software() {
    check_and_cask_install '/Applications/Google Chrome.app' google-chrome
    check_and_cask_install '/Applications/MacVim.app' macvim
    check_and_cask_install '/Applications/Alfred 3.app' alfred
    check_and_cask_install '/Applications/iTerm.app' iterm2
    check_and_cask_install '/Applications/ShadowsocksX.app' shadowsocksx
    check_and_cask_install '/Applications/Caffeine.app' caffeine
    check_and_cask_install '/Applications/Itsycal.app' itsycal
    check_and_cask_install '/Applications/Skim.app' skim
}

install_brew

install_git

install_zsh

install_oh_my_zsh

install_vimrc

install_console_software

install_cask_software
