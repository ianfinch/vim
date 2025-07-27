NVIM_DIR := $(HOME)/.config/nvim
NVIM_SHARE := $(HOME)/.local/share/nvim/

.PHONY: personal
personal:
	mkdir -p $(NVIM_DIR)
	cp init.lua $(NVIM_DIR)/init.lua
	cp -R lua $(NVIM_DIR)/
	cp -R colors $(NVIM_DIR)/

.PHONY: clean
clean:
	rm -rf $(NVIM_DIR)
	rm -rf $(NVIM_SHARE)
