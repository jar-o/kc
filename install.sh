#!/usr/bin/env bash

curl -s https://raw.githubusercontent.com/jar-o/kc/master/.kc > $HOME/.kc
touch $HOME/.kc_custom
chmod +x $HOME/.kc $HOME/.kc_custom
echo "Installed. Please add"; echo
echo "[ -f ~/.kc ] && source ~/.kc"
echo; echo "to the end of the appropriate Bash profile scripts."
