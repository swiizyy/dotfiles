install: zsh starship ssh warp git hushlogin

starship:
	sudo port install starship
	ln -vsf {${PWD},${HOME}}/.config/starship.toml 
zsh:
	sudo port install zsh
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