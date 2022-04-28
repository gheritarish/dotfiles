vim:
	@echo "Building vim"
	-git clone https://github.com/vim/vim.git
	cd vim && \
		./configure --enable-gui=gtk3 --with-features=huge --enable-multibyte \
			--enable-python3interp=yes --with-python3-command=python3 \
			--enable-luainterp=yes --enable-cscope --enable-perlinterp=yes \
			--enable-tclinterp=yes --enable-rubyinterp=yes --enable-largefile \
			--enable-fail-if-missing --with-compiledby=telmar && \
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
	rm -rf ncspot
	@echo "ncspot compiled"

.PHONY: vim ncspot
