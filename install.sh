# install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh

# add vimrc and tmux config
cp .vimrc .tmux.conf ~

# edit the bash config depending on macos or ubuntu
if [ -f ~/.bash_profile ]; then
    cp macos.bash ~/.bash_it/custom
    sed -i '' 's/bobby/powerline/g' ~/.bash_profile
    . ~/.bash_profile
elif [ -f ~/.bashrc ]; then
    sed -i 's/bobby/zork/g' ~/.bashrc
    . ~/.bashrc
fi
