#=======================================
# autoinstall dotfiles 
#=======================================

sudo apt install git && stow && curl 


git clone https://github.com/john-sth/dotfiles.git

cd dotfiles 

git stow . 

