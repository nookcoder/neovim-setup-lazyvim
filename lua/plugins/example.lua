-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },

    -- change some telescope options and a keymap to browse plugin files
    {
      "nvim-telescope/telescope.nvim",
      keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      },
      -- change some options
      opts = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
      },
    },

    -- add tsserver and setup with typescript.nvim instead of lspconfig
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        init = function()
          require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
            vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
          end)
        end,
      },
      ---@class PluginLspOpts
      opts = {
        ---@type lspconfig.options
        servers = {
          -- tsserver will be automatically installed with mason and loaded with lspconfig
          tsserver = {},
          gopls = {
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          tsserver = function(_, opts)
            require("typescript").setup({ server = opts })
            return true
          end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      },
    },

    -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
    -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
    { import = "lazyvim.plugins.extras.lang.typescript" },

    -- add more treesitter parsers
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
          "http",
          "graphql",
        },
      },
    },

    -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
    -- would overwrite `ensure_installed` with the new value.
    -- If you'd rather extend the default config, use the code below instead:
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        -- add tsx and treesitter
        vim.list_extend(opts.ensure_installed, {
          "tsx",
          "typescript",
          "go",
          "gomod",
          "gowork",
          "gosum",
        })
      end,
    },

    -- the opts function can also be used to change the default opts:
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, {
          function()
            return "😄"
          end,
        })
      end,
    },

    -- or you can return new options to override all the defaults
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function()
        return {
          --[[add your custom lualine config here]]
        }
      end,
    },

    -- use mini.starter instead of alpha
    { import = "lazyvim.plugins.extras.ui.mini-starter" },

    -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
    { import = "lazyvim.plugins.extras.lang.json" },

    -- add any tools you want to have installed below
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "stylua",
          "shellcheck",
          "shfmt",
          "flake8",
          "gopls",
          "gofumpt",
          "goimports",
          "golangci-lint",
          "gomodifytags",
          "impl",
          "delve",
        },
      },
    },

    {
      "leoluz/nvim-dap-go",
      opts = {},
    },

    {
      "nvimtools/none-ls.nvim",
      optional = true,
      dependencies = {
        {
          "williamboman/mason.nvim",
          opts = { ensure_installed = { "gomodifytags", "impl" } },
        },
      },
      opts = function(_, opts)
        local nls = require("null-ls")
        opts.sources = vim.list_extend(opts.sources or {}, {
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,
          nls.builtins.formatting.goimports,
          nls.builtins.formatting.gofumpt,
        })
      end,
    },

    {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters_by_ft = {
          go = { "goimports", "gofumpt" },
        },
      },
    },

    {
      "mfussenegger/nvim-dap",
      optional = true,
      dependencies = {
        {
          "williamboman/mason.nvim",
          opts = { ensure_installed = { "delve" } },
        },
        {
          "leoluz/nvim-dap-go",
          opts = {},
        },
      },
    },

    {
      "folke/noice.nvim",
      opts = {
        lsp = {
          hover = {
            enabled = true,
            silent = true, -- 마우스로 hover할 때 메시지 표시 안 함
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true, -- 자동으로 시그니처 도움말 표시
              luasnip = true, -- snippet 지원
            },
          },
        },
        presets = {
          lsp_doc_border = true, -- hover 창에 테두리 추가
        },
      },
    },
  },
}
