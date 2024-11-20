#!/bin/sh
set -xe
#Install Brave
sudo apt install curl git
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt upgrade -y
sudo apt install brave-browser

#Install VSCode
sudo echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt-get install wget gpg
sudo wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

echo "Please install bitwarden,Hackernews in new tab,Sponsorblock,Color picker"

#Setup Github
SSH_DIR="$HOME/.ssh"
KEY_NAME="github"
EMAIL="hiranyeyg@gmail.com"
CONFIG_FILE="$SSH_DIR/config"

mkdir -p "$SSH_DIR"
if [ ! -f "$SSH_DIR/$KEY_NAME" ]; then
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_DIR/$KEY_NAME" -N ""
fi
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/$KEY_NAME"
echo "Copy the following SSH public key and add it to your GitHub account:"
cat "$SSH_DIR/$KEY_NAME.pub"
read -p "Press Enter to proceed: " answer

mkdir -p ~/dev
git clone git@github.com:hiranyey/dotfiles.git ~/dev/dotfiles

#Remove SNAP

#Install packages
sudo apt install curl git alacritty neovim htop btop mpv ranger rofi simplescreenrecorder neofetch build-essential cmake pavucontrol pulseaudio-utils maim tmux xdotool i3 i3blocks autotiling feh -y


#Change default terminal to alacritty
sudo update-alternatives --config x-terminal-emulator

# Run Iosevka.py
echo "Downloading Iosevka font..."
python3 ~/dev/dotfiles/scripts/Iosevka.py

#Install zsh
sudo apt install zsh -y
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#Setup startship
curl -sS https://starship.rs/install.sh | sh

# Install NVM 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

#Install Go
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go

rm ~/.zshrc
cd ~/dev/dotfiles
deploy.sh MANIFEST

mkdir -p ~/Pictures/screenshots
read -p "Reboot now? (Y/n) " reboot_prompt
case $reboot_prompt in
  "" | [yY] | [yY][eE][sS] )
    reboot
  ;;
esac
