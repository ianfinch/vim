SHELL := bash
VIM_DIR := $(HOME)/.vim
BUNDLE_DIR := $(VIM_DIR)/bundle
NVIM_DIR := $(HOME)/.config/nvim

.PHONY: all
all: clean vimrc plugins airline colours snips neovim

.PHONY: vimrc
vimrc:
	cp vimrc $(HOME)/.vimrc

.PHONY: plugins
plugins:
	mkdir -p $(BUNDLE_DIR)
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/chrisbra/Colorizer.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/jeetsukumaran/vim-buffergator.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/kien/rainbow_parentheses.vim.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/tpope/vim-fugitive.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/junegunn/gv.vim.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/tpope/vim-pathogen.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/tpope/vim-vinegar.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/preservim/nerdtree.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/vim-scripts/nginx.vim.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/vim-syntastic/syntastic.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/jelera/vim-javascript-syntax.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/airblade/vim-gitgutter.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/yegappan/mru.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/bullets-vim/bullets.vim.git || true
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/ryanoasis/vim-devicons.git || true

.PHONY: airline
airline:
	mkdir -p $(BUNDLE_DIR)
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/vim-airline/vim-airline.git
	mkdir -p $(VIM_DIR)/autoload/airline/themes
	cp guzo-airline-theme.vim $(VIM_DIR)/autoload/airline/themes/guzo.vim

.PHONY: colours
colours:
	mkdir -p $(VIM_DIR)/colors
	cat iantheme.vim | ./add-gui-colours.sh > $(VIM_DIR)/colors/iantheme.vim
	cp vividchalkian.vim $(VIM_DIR)/colors/vividchalkian.vim

.PHONY: snips
snips:
	mkdir -p $(BUNDLE_DIR)
	git -C $(BUNDLE_DIR) clone --depth 1 https://github.com/SirVer/ultisnips.git
	cp -R UltiSnips $(VIM_DIR)/UltiSnips

.PHONY: neovim
neovim:
	mkdir -p $(NVIM_DIR)
	cp init.vim $(NVIM_DIR)/init.vim

.PHONY: clean
clean:
	rm -f $(HOME)/.vimrc
	rm -rf $(VIM_DIR)
	rm -rf $(NVIM_DIR)
