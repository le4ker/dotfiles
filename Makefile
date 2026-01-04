.PHONY: install update link unlink restart brew-install brew-update services-start services-stop

# Main targets
install: brew-install link services-start
	uninstall: services-stop unlink

update: brew-update
	@echo "Update complete"

# Homebrew
brew-install:
	brew install autojump
	brew install grep
	brew install git
	brew install neovim
	brew install pyenv
	brew install rbenv
	brew install vim
	brew install --cask kitty
	brew tap koekeishiya/formulae
	brew install skhd
	brew install yabai
	brew tap FelixKratz/formulae
	brew install sketchybar
	# zsh-autosuggestions plugin
	@if [ ! -d "$${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then \
		git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions; \
	fi

brew-update:
	brew update
	brew upgrade
	brew cleanup

# Symlinks
link:
	@echo "Creating symlinks..."
	@[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak || true
	ln -sf ~/.config/zsh/zshrc ~/.zshrc
	ln -sf ~/.config/git/config ~/.gitconfig
	mkdir -p ~/.config/kitty && ln -sf ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
	mkdir -p ~/.config/yabai && ln -sf ~/.config/yabai/yabairc ~/.config/yabai/yabairc
	mkdir -p ~/.config/skhd && ln -sf ~/.config/skhd/skhdrc ~/.config/skhd/skhdrc
	@echo "Symlinks created"

unlink:
	@echo "Removing symlinks..."
	rm -f ~/.zshrc
	rm -f ~/.gitconfig
	@[ -f ~/.zshrc.bak ] && mv ~/.zshrc.bak ~/.zshrc || true
	@echo "Symlinks removed"

# Services
services-start:
	skhd --start-service
	yabai --start-service
	brew services start sketchybar

services-stop:
	skhd --stop-service
	yabai --stop-service
	brew services stop sketchybar

restart:
	skhd --restart-service
	yabai --restart-service
	sketchybar --reload

# Help
help:
	@echo "Available targets:"
	@echo "  install        - Install all dependencies and create symlinks"
	@echo "  uninstall      - Stop services and remove symlinks"
	@echo "  update         - Update all Homebrew packages"
	@echo "  link           - Create symlinks only"
	@echo "  unlink         - Remove symlinks only"
	@echo "  restart        - Restart all services"
	@echo "  services-start - Start all services"
	@echo "  services-stop  - Stop all services"
	@echo "  brew-install   - Install Homebrew packages only"
	@echo "  brew-update    - Update Homebrew packages only"
	@echo "  help           - Show this help"
