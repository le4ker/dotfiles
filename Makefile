install:
	# autojump
	brew install autojump
	# GNU grep
	brew install grep
	# git
	brew install git
	# kitty
	brew install --cask kitty
	# skhd
	brew install koekeishiya/formulae/skhd
	skhd --start-service
	# sketchybar
	brew tap FelixKratz/formulae
	brew install sketchybar
	# vim
	brew install vim
	# yabai
	brew install koekeishiya/formulae/yabai
	yabai --start-service
	# replace .zsrhc
	rm ~/.zshrc
	# install zsh-autosuggestions plugin
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	ln -s ~/.config/zsh/zshrc ~/.zshrc

restart:
	sketchybar --reload
	yabai --restart-service
