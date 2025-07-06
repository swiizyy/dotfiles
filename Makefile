install: zsh starship ssh warp git hushlogin

# Void Linux installation with Wayland/Sway support
install-void: install-void-packages zsh starship ssh warp git hushlogin sway waybar swaync ly themes theme-rose-pine

install-void-packages:
	./scripts/install-void.sh

starship:
	./.zsh/package-manager.zsh install starship
	ln -vsf {${PWD},${HOME}}/.config/starship.toml 

zsh:
	./.zsh/package-manager.zsh install zsh
	ln -vsf {${PWD},${HOME}}/.zshrc
	ln -vsf {${PWD},${HOME}}/.zshenv
	ln -vsf {${PWD},${HOME}}/.zsh

ssh:
	ln -vsf {${PWD},${HOME}}/.ssh/config

warp:
	ln -vsf {${PWD},${HOME}}/.warp/

git:
	ln -vsf {${PWD},${HOME}}/.gitconfig
	ln -vsf {${PWD},${HOME}}/.gitignore_global
	ln -vsf {${PWD},${HOME}}/.stCommitMsg

hushlogin:
	ln -vsf {${PWD},${HOME}}/.hushlogin

# Wayland/Sway specific configurations
sway:
	ln -vsf {${PWD},${HOME}}/.config/sway/

waybar:
	ln -vsf {${PWD},${HOME}}/.config/waybar/

swaync:
	ln -vsf {${PWD},${HOME}}/.config/swaync/

# ly display manager configuration
ly:
	ln -vsf {${PWD},${HOME}}/.config/ly/

# Theme management
themes:
	mkdir -p ${HOME}/.config ${HOME}/.local/bin
	ln -vsf ${PWD}/.config/themes/ ${HOME}/.config/themes
	chmod +x ${PWD}/scripts/theme-switcher.sh
	ln -vsf ${PWD}/scripts/theme-switcher.sh ${HOME}/.local/bin/theme-switcher

# Set Rose Pine as default theme
theme-rose-pine:
	${PWD}/scripts/theme-switcher.sh rose-pine

# Set Catppuccin as default theme
theme-catppuccin:
	${PWD}/scripts/theme-switcher.sh catppuccin

# Package manager commands
update:
	./.zsh/package-manager.zsh update