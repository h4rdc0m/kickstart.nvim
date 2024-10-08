return {
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      stop_after_first = {
        php = { { 'pint', 'php_cs_fixer' } },
      },
    },
  },
  {
    -- Add neotest-pest plugin for running PHP tests.
    -- A package is also available for PHPUnit if needed.
    'nvim-neotest/neotest',
    dependencies = { 'V13Axel/neotest-pest' },
    opts = { adapters = { 'neotest-pest' } },
  },
  {
    -- Add a Treesitter parser for Laravel Blade to provide Blade syntax highlighting.
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'blade',
        'php_only',
      })
    end,
    config = function(_, opts)
      vim.filetype.add {
        pattern = {
          ['.%.blade%.php'] = 'blade',
        },
      }

      require('nvim-treesitter.configs').setup(opts)

      ---@class ParserInfo[]
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }
    end,
  },
  {
    -- Add the blade-nav.nvim plugin which provides Goto File capabilities
    -- for Blade files.
    'ricardoramirezr/blade-nav.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    ft = { 'blade', 'php' },
  },
}
