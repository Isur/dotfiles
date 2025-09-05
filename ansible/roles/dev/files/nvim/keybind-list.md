# Neovim Keybind List

## Custom changes to defaults
Visual mode:
J - moves line down
K - moves line up

# Leader start
## Single key
<leader>a - swap next parameter
<leader>A - swap previous parameter
<leader>e - File Explorer - Oil
<leader>x - Close buffer
<leader>u - Undootree
<leader>D - go to type definition

## c - code
<leader>ca - code actions
<leader>cf - code format

## n - highlights
<leader>nh - Clear search highlights

## h - harpoon
<leader>h - show harpoon
<leader>hh - add to harpoon
<leader>1 - select (1 - 5)
<leader><Tab> - next in harpoon
<leader><S-Tab> - prev in harpoon

## k - go to preview
<leader>kk - definition window
<leader>kq - close preview windows
<leader>kt - type window
<leader>kr - references window
<leader>ki - implementation window


## s - search & spellcheck
<leader>sf - find files
<leader>sh - help tags
<leader>sk - keymaps
<leader>so - previously openend files
<leader>sg - live grep
<leader>ss - git status
<leader>sc - spell check suggest
<leader>st - todo
<leader>/ - fuzzy search in current buffer
<leader><space> - find existing buffers

<leader>S - spectre toggle
<leader>sw - spectre search selected word
<leader>sp - spectre search in current file

## f
<leader>fp - Copy file path

## r
<leader>rn - rename

## m
<leader>mm - MaximizerToggle

## d - trouble & debug
<leader>dd - Trouble Diagnostics
<leader>dx - Trouble Buffer Diagnostics
<leader>ds - Trouble Symbols

<leader>dc - debug continue
<leader>db - debug breakpoint
<leader>dr - debug repl
<leader>dw - debug ui open
<leader>dW - debug ui close

## t - testing
<leader>tf - test run file
<leader>tt - test run test
<leader>tS - test run suite
<leader>tl - test run last
<leader>to - test output
<leader>tO - test output panel
<leader>tT - test terminate
<leader>td - debug nearest
<leader>tD - debug current file

## w - workspace
<leader>wa - add workspace directory
<leader>wr - remove workspace directory
<leader>wl - list workspace directory

## g - git
<leader>gg - lazygit
<leader>gf - git file history
<leader>gh - git preview hunk
<leader>gp - git prev hunk
<leader>gn - git next hunk
<leader>gs - git stage hunk
<leader>gr - git reset hunk


# Non Leader start
## diagnostics
[d  - previous
]d  - next
dp - open diagnostic message in float window

gd - go to definition
gr - go to references
gI - go to implementation
gD - go to declaration

K - hover documentation

s - flash jump
S - flash select

## z
zR - Open all folds
zM - Close all folds
zK - Peak fold
za - Toggle fold

## s - surrounding
sa - add
sd - delete
sf - find right
sF - find left
sh - highlights
sr - replace
sn - update n lines

## ctrl
ctrl-k - toggle lsp signature
