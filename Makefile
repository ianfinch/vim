VIM_DIR := $(HOME)/.vim
BUNDLE_DIR := $(VIM_DIR)/bundle

NVIM_DIR := $(HOME)/.config/nvim
PACK_DIR := $(NVIM_DIR)/pack/vendor/start

define add_vim_plugin
	$(eval $@_repo = $(1))
	[ ! -d "$(BUNDLE_DIR)" ] || git -C $(BUNDLE_DIR) clone --depth 1 ${$@_repo} || true
endef

define add_nvim_plugin
	$(eval $@_repo = $(1))
	[ ! -d "$(PACK_DIR)" ] || git -C $(PACK_DIR) clone --depth 1 ${$@_repo} || true
endef

define add_common_plugin
	$(eval $@_repo = $(1))
	@$(call add_vim_plugin,${$@_repo})
	@$(call add_nvim_plugin,${$@_repo})
endef

define mk_vim_dir
	$(eval $@_path = $(1))
	[ ! -d "$(VIM_DIR)" ] || mkdir -p $(VIM_DIR)/${$@_path}
endef

define mk_nvim_dir
	$(eval $@_path = $(1))
	[ ! -d "$(NVIM_DIR)" ] || mkdir -p $(NVIM_DIR)/${$@_path}
endef

.PHONY: all
all: clean vimrc vim_plugins nvim_init nvim_plugins common

.PHONY: vim
vim: vimrc vim_plugins common

.PHONY: nvim
nvim: nvim_init nvim_plugins common

.PHONY: common
common: common_plugins airline colours

.PHONY: vimrc
vimrc:
	cp vimrc $(HOME)/.vimrc
	mkdir -p $(BUNDLE_DIR)
	@$(call add_vim_plugin,https://github.com/tpope/vim-pathogen.git)

.PHONY: nvim_init
nvim_init:
	mkdir -p $(PACK_DIR)
	cp init.lua $(NVIM_DIR)/init.lua

.PHONY: vim_plugins
vim_plugins:
	@echo "TBD"

.PHONY: nvim_plugins
nvim_plugins:
	@echo "TBD"

.PHONY: common_plugins
common_plugins:
	@$(call add_common_plugin,https://github.com/chrisbra/Colorizer.git)
	@$(call add_common_plugin,https://github.com/jeetsukumaran/vim-buffergator.git)
	@$(call add_common_plugin,https://github.com/kien/rainbow_parentheses.vim.git)
	@$(call add_common_plugin,https://github.com/tpope/vim-fugitive.git)
	@$(call add_common_plugin,https://github.com/junegunn/gv.vim.git)
	@$(call add_common_plugin,https://github.com/tpope/vim-vinegar.git)
	@$(call add_common_plugin,https://github.com/preservim/nerdtree.git)
	@$(call add_common_plugin,https://github.com/vim-scripts/nginx.vim.git)
	@$(call add_common_plugin,https://github.com/vim-syntastic/syntastic.git)
	@$(call add_common_plugin,https://github.com/jelera/vim-javascript-syntax.git)
	@$(call add_common_plugin,https://github.com/airblade/vim-gitgutter.git)
	@$(call add_common_plugin,https://github.com/yegappan/mru.git)
	@$(call add_common_plugin,https://github.com/bullets-vim/bullets.vim.git)
	@$(call add_common_plugin,https://github.com/ryanoasis/vim-devicons.git)

.PHONY: airline
airline:
	@$(call add_common_plugin,https://github.com/vim-airline/vim-airline.git)
	[ ! -d "$(BUNDLE_DIR)/vim-airline/autoload/airline/themes" ] || cp guzo-airline-theme.vim $(BUNDLE_DIR)/vim-airline/autoload/airline/themes/guzo.vim
	[ ! -d "$(PACK_DIR)/vim-airline/autoload/airline/themes" ] || cp guzo-airline-theme.vim $(PACK_DIR)/vim-airline/autoload/airline/themes/guzo.vim

iantheme.vim: iantheme_cterm.vim
	cat iantheme_cterm.vim | ./add-gui-colours.sh > iantheme.vim

.PHONY: colours
colours: iantheme.vim
	@$(call mk_vim_dir,/colors)
	[ ! -d "$(VIM_DIR)/colors" ] || cp iantheme.vim $(VIM_DIR)/colors/iantheme.vim
	@$(call mk_nvim_dir,/colors)
	[ ! -d "$(NVIM_DIR)/colors" ] || cp iantheme.vim $(NVIM_DIR)/colors/iantheme.vim

.PHONY: clean
clean:
	rm -f $(HOME)/.vimrc
	rm -rf $(VIM_DIR)
	rm -rf $(NVIM_DIR)
