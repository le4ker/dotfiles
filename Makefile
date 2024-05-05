install:
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
	# setup symbolic links
	ln -s ~/.config/zsh/zshrc ~/.zshrc
