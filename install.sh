# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# add vimrc and tmux config
cp .vimrc .tmux.conf ~

# edit the bash config depending on macos or linux
if [[ "$(uname -s)" == "Darwin" ]]; then
    cp macos.zsh ~/.oh-my-zsh/custom/
    sed -i '' 's/robbyrussell/ys/g' ~/.zshrc
elif [[ "$(uname -s)" == "Linux" ]]; then
    sed -i 's/robbyrussell/ys/g' ~/.zshrc
fi
