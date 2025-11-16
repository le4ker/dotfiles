install:
	brew install autojump
	# GNU grep
	brew install grep
	brew install git
	brew install pyenv
	brew install --cask kitty
	brew install koekeishiya/formulae/skhd
	skhd --start-service
	brew tap FelixKratz/formulae
	brew install sketchybar
	brew install vim
	brew install koekeishiya/formulae/yabai
	yabai --start-service
	# install zsh-autosuggestions plugin
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	# replace .zsrhc
	mv ~/.zshrc ~/.zshrc_old
	ln -s ~/.config/zsh/zshrc ~/.zshrc

restart:
	sketchybar --reload
	yabai --restart-service
