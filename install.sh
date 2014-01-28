#!/bin/bash

# Vimconfig installation variables
vimc__install_home=~/
vimc__install_cwd="$(pwd)"

# check if .vimrc already exists
if [ -f "$vimc__install_home"/.vimrc ]; then
  while true; do
    read -p "~/.vimrc already exists -- Overwrite? (y/n) " choice

    case "$choice" in
      y|Y ) cp -f "$vimc__install_cwd"/vimrc "$vimc__install_home"/.vimrc; break;;
      n|N ) exit;;
      * ) echo "Please answer y or n";;
    esac
  done
else
  echo "Copying vimconfig's .vimrc to ~/.vimrc"
  cp "$vimc__install_cwd"/vimrc "$vimc__install_home"/.vimrc
fi

echo ".. Successfully copied vimrc to ~/.vimrc"

# check if .vim folder already exists
if [ -d "$vimc__install_home"/.vim ]; then
  while true; do
    read -p "~/.vim directory already exists -- Overwrite? (y/n) " choice

    case "$choice" in
      y|Y ) cp -rf "$vimc__install_cwd"/vim/ "$vimc__install_home"/.vim/; break;;
      n|N ) exit;;
      * ) echo "Please answer y or n";;
    esac
  done
else
  echo "Copying vimconfig's .vim/ to ~/.vim/"
  cp -r "$vimc__install_cwd"/vim/ "$vimc__install_home"/.vim/
fi

echo ".. Successfully copied vim/ to ~/.vim/"

echo ""
echo "Your config has successfully been installed. Restart all Vim instances."
echo "Thank you for using ProVim !"
