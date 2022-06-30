vim:
	@echo "Building vim"
	-git clone https://github.com/vim/vim.git
	cd vim && \
		./configure --enable-gui=gtk3 --with-features=huge --enable-multibyte \
			--enable-python3interp=yes --with-python3-command=python3 \
			--enable-luainterp=yes --enable-cscope --enable-perlinterp=yes \
			--enable-tclinterp=yes --enable-rubyinterp=yes --enable-largefile \
			--enable-fail-if-missing --enable-terminal --with-compiledby=telmar && \
		make && \
		sudo make install
	rm -rf vim
	@echo "vim compiled"

ncspot:
	@echo "Building ncspot"
	-git clone https://github.com/hrkfdn/ncspot.git git-ncspot
	cd git-ncspot && \
		cargo build --release --features cover && \
		sudo mv target/release/ncspot /usr/local/bin
	rm -rf git-ncspot
	@echo "ncspot compiled"

# Packages for development. Note: need pikaur to work!
dev-env:
	sudo pacman -S fzf ripgrep tig git-delta ctags

# Base packages: to install before i3. Doesn't install zsh
base:
	sudo pacman -S alacritty bat dfc dust feh ranger redshift tmux vlc xclip zathura zathura-pdf-mupdf
	pikaur -S macchina

# Install all packages needed for i3
i3:
	sudo pacman -S brightnessctl dunst i3-gaps picom playerctl polybar rofi scrot

# Install all base configuration files
config-base:
	@echo "Copying configurations where they should"
	cp ./alacritty ../.config
	cp ./bat ../.config/
	cp ./macchina ../.config
	cp ./zathura ../.config
	cp ./.vimrc ../.vimrc
	cp ./.zshrc ../.zshrc
	co ./redshift.conf ../.config/redshift.conf
	@echo "Copying wallpapers to Pictures folder"
	cp ./Pictures/*.png ../Pictures
	cp ./Pictures/*.jpg ../Pictures
	@echo "Files copied"

# Install all i3 related configuration files
config-i3:
	@echo "Copying i3 configurations where they should"
	cp ./dunst ../.config
	cp ./i3 ../.config
	cp ./picom ../.config
	cp ./polybar ../.config
	cp ./rofi ../.config
	@echo "Saving script to remove scrot screenshots"
	cp ./clean_screenshots ../clean_screenshots
	@echo "Files compiled"

.PHONY: vim ncspot dev-env base i3 config-base config-i3
