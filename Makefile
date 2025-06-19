vim:
	@echo "Building vim"
	-git clone https://github.com/vim/vim.git
	cd vim && \
		./configure --enable-gui=gtk4 --with-features=huge --enable-multibyte \
			--enable-python3interp=yes --with-python3-command=python3 --enable-luainterp=yes \
			--enable-cscope --enable-rubyinterp=yes --enable-largefile \
			--enable-fail-if-missing --enable-terminal --with-compiledby=telmar --with-vim-name=vi && \
		make -j $$(nproc) && \
		sudo make install
	rm -rf vim
	@echo "vim compiled"

neovim:
	@echo "Building nvim"
	-git clone https://github.com/neovim/neovim
	cd neovim && \
		make CMAKE_BUILD_TYPE=RelWithDebInfo && \
		sudo make install
	rm -rf neovim
	echo "neovim compiled"

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
	sudo apt install fzf ripgrep tig universal-ctags

# Base packages: to install before i3. Doesn't install zsh
base:
	sudo apt install bat dfc feh ranger redshift tmux vlc xclip zathura alacritty
	# sudo pacman -S alacritty bat dfc dust feh ranger redshift tmux vlc xclip zathura zathura-pdf-mupdf

# Install all packages needed for i3
i3:
	sudo apt install brightnessctl dunst i3 picom playerctl polybar rofi scrot xbacklight light
	# sudo pacman -S brightnessctl dunst i3-gaps picom playerctl polybar rofi scrot xorg-xbacklight

# Install all base configuration files
config-base:
	@echo "Copying configurations where they should"
	cp -r ./alacritty ../.config
	cp -r ./bat ../.config
	cp -r ./macchina ../.config
	cp -r ./zathura ../.config
	cp ./.vimrc ../.vimrc
	cp ./.zshrc ../.zshrc
	cp ./.tigrc ../.tigrc
	cp ./redshift.conf ../.config/redshift.conf
	@echo "Copying wallpapers to Pictures folder"
	cp ./Pictures/*.png ../Pictures
	cp ./Pictures/*.jpg ../Pictures
	cp -r ./nvim ../.config
	@echo "Files copied"

# Install all i3 related configuration files
config-i3:
	@echo "Copying i3 configurations where they should"
	cp -r ./dunst ../.config
	cp -r ./i3 ../.config
	cp -r ./picom ../.config
	cp -r ./polybar ../.config
	cp -r ./rofi ../.config
	@echo "Saving script to remove scrot screenshots"
	cp ./clean_screenshots ../clean_screenshots
	chmod +x ../clean_screenshots
	@echo "Files compiled"

i3-lock:
	@echo "Building i3lock-color"
	-git clone https://github.com/Raymo111/i3lock-color.git
	cd i3lock-color && ./install-i3lock-color.sh
	@echo "i3lock-color installed"
	rm -rf i3lock-color

.PHONY: vim neovim ncspot dev-env base i3 config-base config-i3
