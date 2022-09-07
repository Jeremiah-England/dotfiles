" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'hrsh7th/nvim-compe'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'b3nj5m1n/kommentary'
Plug 'danymat/neogen'
" Plug 'tpope/vim-sleuth'  " See https://github.com/tpope/vim-sleuth/issues/6
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'folke/zen-mode.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'github/copilot.vim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'alfredodeza/pytest.vim'
Plug 'junegunn/vader.vim'
" Plug 'sakhnik/nvim-gdb'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rcarriga/nvim-dap-ui'
Plug 'https://gitlab.com/HiPhish/info.vim.git'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'chentoast/marks.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'ttibsi/pre-commit.nvim'
Plug 'SirVer/ultisnips'
call plug#end()

let g:python3_host_prog = '/path/to/python3'


lua << EOF
require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF

" Telescope configs
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').builtin()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>

lua << EOF
require('neogen').setup {
    enabled = true,
    languages = {
        python = {
            template = {
                annotation_convention = "numpydoc"
                }
        },
    }
}
EOF

lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" from https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
lua << EOF

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver", "sumneko_lua", "bashls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF


" https://github.com/folke/tokyonight.nvim
lua << EOF
vim.cmd[[colorscheme tokyonight]]
EOF

" https://github.com/hrsh7th/nvim-compe
lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


" Taken from
" https://github.com/nvim-treesitter/nvim-treesitter#available-modules

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    kemaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set mouse=a
set number

" https://vi.stackexchange.com/a/4175/32095
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

let g:copilot_enabled = v:false

" https://github.com/shumphrey/fugitive-gitlab.vim
let g:fugitive_gitlab_domains = ['https://gitlab.visiostack.com']

" DAP Configurations
lua <<EOF
require('dap-python').test_runner = "pytest"
require('dap-python').setup()
require('dapui').setup()
EOF

nnoremap <silent> <Leader>dc <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <Leader>dn <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <Leader>ds <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <Leader>du <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>db <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>dB <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>


" Keymappings info.vim
" See https://stackoverflow.com/a/20105502/9849440
autocmd FileType info nnoremap <buffer> in :InfoNext<CR>
autocmd FileType info nnoremap <buffer> ip :InfoPrev<CR>
autocmd FileType info nnoremap <buffer> iu :InfoUp<CR>
autocmd FileType info nnoremap <buffer> <Enter> :Follow<CR>
autocmd FileType info nnoremap <buffer> ig :GotoNode
autocmd FileType info nnoremap <buffer> im :Menu


" Open the python documentation for a module.
nnoremap <silent> <Leader>op <Cmd>!open "https://docs.python.org/3/library/<cword>.html"<CR>

" Open this "rc" file quickly.
nnoremap <silent> <Leader>rc <Cmd>tabe $MYVIMRC<CR>

" Open the termianl quickly in a split window below
nnoremap <silent> <Leader>t <Cmd>split <CR><C-w>j<Cmd>term<CR>a

autocmd FileType markdown set spell



iabbrev docs documentation
iabbrev Docs Documentation
iabbrev PTO Paid Time Off
iabbrev Jan January
iabbrev Feb February
iabbrev powerpoint PowerPoint
iabbrev Gitlab GitLab
iabbrev MRs merge requests
iabbrev MR merge request


lua << EOF
-- https://github.com/chentoast/marks.nvim#setup
-- require'marks'.setup {
--   -- whether to map keybinds or not. default true
--   default_mappings = true,
--   -- which builtin marks to show. default {}
--   builtin_marks = { ".", "<", ">", "^" },
--   -- whether movements cycle back to the beginning/end of buffer. default true
--   cyclic = true,
--   -- whether the shada file is updated after modifying uppercase marks. default false
--   force_write_shada = false,
--   -- how often (in ms) to redraw signs/recompute mark positions. 
--   -- higher values will have better performance but may cause visual lag, 
--   -- while lower values may cause performance penalties. default 150.
--   refresh_interval = 250,
--   -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
--   -- marks, and bookmarks.
--   -- can be either a table with all/none of the keys, or a single number, in which case
--   -- the priority applies to all marks.
--   -- default 10.
--   sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
--   -- disables mark tracking for specific filetypes. default {}
--   excluded_filetypes = {},
--   -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
--   -- sign/virttext. Bookmarks can be used to group together positions and quickly move
--   -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
--   -- default virt_text is "".
--   bookmark_0 = {
--     sign = "⚑",
--     virt_text = "hello world",
--     -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
--     -- defaults to false.
--     annotate = false,
--   },
--   mappings = {}
-- }
EOF

lua << EOF
-- https://github.com/kyazdani42/nvim-tree.lua#setup
-- empty setup using defaults
require("nvim-tree").setup()
EOF

" B for "Browse"
nnoremap <silent> <Leader>b <Cmd>NvimTreeToggle<CR>

" SnipRun config. See https://github.com/michaelb/sniprun/blob/master/README.md#configuration
lua << EOF
require("sniprun").setup({
  selected_interpreters = {'Python3_original'},     --# use those instead of the default for the current filetype
  repl_enable = {'Python3_original'},  --# enable REPL-like behavior for the given interpreters
  repl_disable = {},              --# disable REPL-like behavior for the given interpreters

  interpreter_options = {         --# interpreter-specific options, see docs / :SnipInfo <name>

    --# use the interpreter name as key
    GFM_original = {
      use_on_filetypes = {"markdown.pandoc"}    --# the 'use_on_filetypes' configuration key is
                                                --# available for every interpreter
    },
    Python3_original = {
        error_truncate = "auto"         --# Truncate runtime errors 'long', 'short' or 'auto'
                                        --# the hint is available for every interpreter
                                        --# but may not be always respected
    }
  },      

  --# you can combo different display modes as desired
  display = {
    -- "Classic",                    --# display results in the command-line  area
    -- "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)

    -- "VirtualTextErr",          --# display error results as virtual text
    -- "TempFloatingWindow",      --# display results in a floating window
    -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText__
    -- "Terminal",                --# display results in a vertical split
    "TerminalWithCode",        --# display results and code history in a vertical split
    -- "NvimNotify",              --# display with the nvim-notify plugin
    -- "Api"                      --# return output to a programming interface
  },

  display_options = {
    terminal_width = 45,       --# change the terminal display option width
    notification_timeout = 5   --# timeout for nvim_notify output
  },

  --# You can use the same keys to customize whether a sniprun producing
  --# no output should display nothing or '(no output)'
  show_no_output = {
    "Classic",
    "TempFloatingWindow",      --# implies LongTempFloatingWindow, which has no effect on its own
  },

  --# customize highlight groups (setting this overrides colorscheme)
  snipruncolors = {
    SniprunVirtualTextOk   =  {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
    SniprunFloatingWinOk   =  {fg="#66eeff",ctermfg="Cyan"},
    SniprunVirtualTextErr  =  {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
    SniprunFloatingWinErr  =  {fg="#881515",ctermfg="DarkRed"},
  },

  --# miscellaneous compatibility/adjustement settings
  inline_messages = 0,             --# inline_message (0/1) is a one-line way to display messages
				   --# to workaround sniprun not being able to display anything

  borders = 'single',              --# display borders around floating windows
                                   --# possible values are 'none', 'single', 'double', or 'shadow'
  live_mode_toggle='off'       --# live mode toggle, see Usage - Running for more info   
})
EOF

" Insert a date at the end of the current line.
nnoremap <silent> <Leader>di <Cmd>r! date -I<CR>i<BS><Space><ESC>E

" From the lspsaga README on github
lua << EOF
local action = require("lspsaga.codeaction")

vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
EOF

vnoremap <Leader>sr <ESC><Cmd>'<,'>SnipRun<CR>
nnoremap <Leader>sr <ESC><Cmd>SnipRun<CR>

" https://github.com/glacambre/firenvim/#building-a-firenvim-specific-config
if exists('g:started_by_firenvim')
  set spell
  set filetype=markdown
endif
