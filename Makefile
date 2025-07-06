install: zsh starship ssh warp git hushlogin

# Void Linux installation with Wayland/Sway support
install-void: install-void-packages zsh-void starship-void ssh warp git hushlogin sway waybar swaync

install-void-packages:
	./scripts/install-void.sh

starship:
	sudo port install starship
	ln -vsf {${PWD},${HOME}}/.config/starship.toml 

starship-void:
	ln -vsf {${PWD},${HOME}}/.config/starship.toml 

zsh:
	sudo port install zsh
	ln -vsf {${PWD},${HOME}}/.zshrc
	ln -vsf {${PWD},${HOME}}/.zshenv
	ln -vsf {${PWD},${HOME}}/.zsh

zsh-void:
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