local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },

		-- [언어별 엑스트라 모듈 활성화]
		-- Go: gopls, gofumpt, delve(디버거) 포함
		{ import = "lazyvim.plugins.extras.lang.go" },

		-- TypeScript: vtsls(최신), prettier, eslint 포함
		{ import = "lazyvim.plugins.extras.lang.typescript" },

		-- Python: pyright, black, isort, debugpy 포함
		{ import = "lazyvim.plugins.extras.lang.python" },

		-- Terraform: terraform-ls, tflint 포함
		{ import = "lazyvim.plugins.extras.lang.terraform" },

		-- JSON, YAML (설정 파일 다룰 때 필수)
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.yaml" },

		-- [추가 도구]
		-- Docker (Dockerfile 하이라이팅 및 진단)
		{ import = "lazyvim.plugins.extras.lang.docker" },

		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "tokyonight", "habamax", "gruvbox" } },
	checker = {
		enabled = true, -- check for plugin updates periodically
		notify = false, -- notify on update
	}, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
