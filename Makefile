ifdef OS # Windows
	NVIM_DIR := $${HOME}/AppData/Local/nvim
	NVIM_SHARE := $${HOME}/AppData/Local/nvim-data
	SERVER_CONFIG := $${HOME}/.live-server.json
else
	NVIM_DIR := $${HOME}/.config/nvim
	NVIM_SHARE := $${HOME}/.local/share/nvim/
	SERVER_CONFIG := $${HOME}/.live-server.json
endif

.PHONY: personal
personal:
	mkdir -p $(NVIM_DIR)
	cp init.lua $(NVIM_DIR)/init.lua
	cp -R lua $(NVIM_DIR)/
	cp -R colors $(NVIM_DIR)/
	mkdir -p $(NVIM_SHARE)
	cp -R "live-server" $(NVIM_SHARE)/
	(echo "let systemDir = '$(NVIM_SHARE)/live-server';" ; cat "live-server/middleware.js") > "$(NVIM_SHARE)/live-server/middleware.js"
	cat config/live-server.json | sed -e "s#__SERVER_DIR__#$(NVIM_SHARE)/live-server#" > "$(SERVER_CONFIG)"

.PHONY: clean
clean:
	rm -rf $(NVIM_DIR)
	rm -rf $(NVIM_SHARE)
