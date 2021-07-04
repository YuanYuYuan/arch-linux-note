vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'AndrewRadev/splitjoin.vim'
  use 'mg979/vim-visual-multi'
  use {
   'junegunn/vim-easy-align',
    config = vim.cmd [[
      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)
    ]]
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = vim.cmd [[
      nnoremap <F1> :NvimTreeToggle<CR>
    ]]
  }
  use {
    'iamcco/markdown-preview.nvim',
    ft = "markdown",
    run = 'cd app && yarn install',
    config = vim.cmd [[
      let g:mkdp_auto_close = 0
      autocmd FileType markdown inoremap <buffer> <silent> <F3> <Esc>:MarkdownPreview<CR>
      autocmd FileType markdown nnoremap <buffer> <silent> <F3> :MarkdownPreview<CR>
    ]]
  }
  use 'alvan/vim-closetag'
  use 'Yggdroot/indentLine'

  -- colorscheme
  use 'rakr/vim-one'
  use 'glepnir/zephyr-nvim'
  use 'lifepillar/vim-solarized8'
  use {
    'norcalli/nvim-colorizer.lua',
    config = [[require 'colorizer'.setup()]]
  }

  use {
    'scrooloose/nerdcommenter',
    config = vim.cmd [[
      " Add spaces after comment delimiters by default
      let g:NERDSpaceDelims            = 1

      " Disable commenting empty lines
      let g:NERDCommentEmptyLines      = 0

      " use compact syntax for prettified multi-line comments
      let g:NERDCompactSexyComs        = 1

      " trim trailing whitespace
      let g:NERDTrimTrailingWhitespace = 1

      " left align the comment
      let g:NERDDefaultAlign           = 'left'

      " wisely comment on a region
      let g:NERDToggleCheckAllLines = 1

      nmap <BS> <plug>NERDCommenterToggle
      vmap <BS> <plug>NERDCommenterToggle
    ]]
  }
  use {
    'yegappan/mru',
    config = vim.cmd [[
      nnoremap <Space>f :MRU<CR>
    ]]
  }
  use {
    'tpope/vim-surround',
    config = vim.cmd [[
      let g:surround_no_mappings = 1
      nmap ds <Plug>Dsurround
      nmap cs <Plug>Csurround
      xmap s <Plug>VSurround
      xmap gs <Plug>VgSurround
    ]]
  }
  use {
    'jiangmiao/auto-pairs',
    config = vim.cmd [[
      " Disable some shortcuts
      let g:AutoPairsShortcutBackInsert = ''
      let g:AutoPairsShortcutToggle = ''
    ]]
  }
  use {
    'hrsh7th/nvim-compe',
    config = [[require'plugins.compe']]
  }
  use 'kyazdani42/nvim-web-devicons'
  use {
    'akinsho/nvim-bufferline.lua',
    config = [[require'plugins.bufferline']]
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require'plugins.treesitter']]
  }
  use 'nvim-treesitter/playground'

  use {
    'lervag/vimtex',
    ft = 'tex',
    config = vim.cmd [[
      " viewer
      let g:vimtex_view_method = 'zathura'
      let g:vimtex_compiler_progname = 'nvr'

      let maplocalleader = ";"

      " avoid plaintex
      let g:tex_flavor='latex'

      let g:vimtex_view_method = 'zathura'
      " let g:vimtex_fold_manual=0

      " enable folding
      let g:vimtex_fold_enabled=1
    ]]
  }
  use 'itchyny/vim-cursorword'
  use 'onsails/lspkind-nvim'
  use 'glepnir/lspsaga.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'FooSoft/vim-argwrap',
    config = vim.cmd [[
      nnoremap <silent> <Space>a :ArgWrap<CR>
    ]]
  }
  use {
    'simrat39/rust-tools.nvim',
    -- ft = 'rust',
    config = function()
      require('plugins.rust')
      vim.cmd [[
        nnoremap <F3> :RustRunnables<CR>
        inoremap <F3> <Esc>:RustRunnables<CR>
      ]]
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use {
    'nvim-lua/lsp-status.nvim',
    config = [[require'plugins.lsp']]
  }
  use 'nvim-telescope/telescope.nvim'
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = [[require'plugins.statusline']]
  }
end)
