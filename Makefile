ifdef OS # Windows
	NVIM_DIR := $${HOME}/AppData/Local/nvim
	NVIM_SHARE := $${HOME}/AppData/Local/nvim-data
else
	NVIM_DIR := $${HOME}/.config/nvim
	NVIM_SHARE := $${HOME}/.local/share/nvim/
endif

.PHONY: personal
personal:
	mkdir -p $(NVIM_DIR)
	cp init.lua $(NVIM_DIR)/init.lua
	cp -R lua $(NVIM_DIR)/
	cp -R colors $(NVIM_DIR)/
	mkdir -p $(NVIM_SHARE)
	cp -R assets $(NVIM_SHARE)/

.PHONY: clean
clean:
	rm -rf $(NVIM_DIR)
	rm -rf $(NVIM_SHARE)
