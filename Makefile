.PHONY: install update link unlink restart brew-install brew-update services-start services-stop

# Main targets
install: brew-install link services-start

uninstall: services-stop unlink

update: brew-update
	@echo "Update complete"

# Homebrew
brew-install:
	brew install autojump || true
	brew install grep || true
	brew install git || true
	brew install neovim || true
	brew install pyenv || true
	brew install rbenv || true
	brew install vim || true
	brew install --cask kitty || true
	brew tap koekeishiya/formulae || true
	brew install skhd || true
	brew install yabai || true
	brew tap FelixKratz/formulae || true
	brew install sketchybar || true
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
	skhd --stop-service || true
	skhd --start-service
	yabai --stop-service || true
	yabai --start-service
	brew services restart sketchybar

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
