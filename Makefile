NVIM_DIR := $(HOME)/.config/nvim
NVIM_SHARE := $(HOME)/.local/share/nvim/

.PHONY: all
all: personal colours

.PHONY: personal
personal:
	mkdir -p $(NVIM_DIR)
	cp init.lua $(NVIM_DIR)/init.lua
	cp -R lua $(NVIM_DIR)/

iantheme.vim: iantheme_cterm.vim
	cat iantheme_cterm.vim | ./add-gui-colours.sh > iantheme.vim

.PHONY: colours
colours: iantheme.vim
	mkdir -p $(NVIM_DIR)/colors
	cp iantheme.vim $(NVIM_DIR)/colors/iantheme.vim

.PHONY: clean
clean:
	rm -rf $(NVIM_DIR)
	rm -rf $(NVIM_SHARE)
