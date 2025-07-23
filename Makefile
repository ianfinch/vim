VIM_DIR := $(HOME)/.vim
BUNDLE_DIR := $(VIM_DIR)/bundle

NVIM_DIR := $(HOME)/.config/nvim

define add_vim_plugin
	$(eval $@_repo = $(1))
	[ ! -d "$(BUNDLE_DIR)" ] || git -C $(BUNDLE_DIR) clone --depth 1 ${$@_repo} || true
endef

define add_common_plugin
	$(eval $@_repo = $(1))
	@$(call add_vim_plugin,${$@_repo})
endef

define mk_vim_dir
	$(eval $@_path = $(1))
	[ ! -d "$(VIM_DIR)" ] || mkdir -p $(VIM_DIR)/${$@_path}
endef

.PHONY: all
all: clean vim nvim

.PHONY: vim
vim: vimrc vim_plugins common_plugins airline colours snips

.PHONY: nvim
nvim: nvim_init nvim_plugins common_plugins

.PHONY: vimrc
vimrc:
	cp vimrc $(HOME)/.vimrc
	mkdir -p $(BUNDLE_DIR)
	@$(call add_vim_plugin,https://github.com/tpope/vim-pathogen.git)

.PHONY: nvim_init
nvim_init:
	mkdir -p $(NVIM_DIR)
	cp init.vim $(NVIM_DIR)/init.vim

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
	@$(call mk_vim_dir,/autoload/airline/themes)
	[ ! -d "$(VIM_DIR)/autoload/airline/themes" ] || cp guzo-airline-theme.vim $(VIM_DIR)/autoload/airline/themes/guzo.vim

.PHONY: colours
colours:
	@$(call mk_vim_dir,/colors)
	cat iantheme.vim | ./add-gui-colours.sh > $(VIM_DIR)/colors/iantheme.vim
	[ ! -d "$(VIM_DIR)/colors" ] || cp vividchalkian.vim $(VIM_DIR)/colors/vividchalkian.vim

.PHONY: snips
snips:
	@$(call add_common_plugin,https://github.com/SirVer/ultisnips.git)
	[ ! -d "$(VIM_DIR)" ] || cp -R UltiSnips $(VIM_DIR)/UltiSnips

.PHONY: clean
clean:
	rm -f $(HOME)/.vimrc
	rm -rf $(VIM_DIR)
	rm -rf $(NVIM_DIR)
