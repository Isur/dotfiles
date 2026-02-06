# Neovim Keybind List

## Custom Changes to Defaults

**Visual mode:**
- `J` - Move line down
- `K` - Move line up

---

## Leader Key Bindings

### Single Key Actions
- `<leader>a` - Swap next parameter
- `<leader>A` - Swap previous parameter
- `<leader>e` - File Explorer (Oil)
- `<leader>D` - Go to type definition

### Code (`<leader>c`)
- `<leader>ca` - Code actions
- `<leader>cf` - Code format

### Highlights (`<leader>n`)
- `<leader>nh` - Clear search highlights

### Harpoon (`<leader>h`)
- `<leader>h` - Show harpoon menu
- `<leader>hh` - Add to harpoon
- `<leader>1` - Select harpoon file 1
- `<leader>2` - Select harpoon file 2
- `<leader>3` - Select harpoon file 3
- `<leader>4` - Select harpoon file 4
- `<leader>5` - Select harpoon file 5
- `<leader><Tab>` - Next in harpoon
- `<leader><S-Tab>` - Previous in harpoon

### Search & Picker (`<leader>s`)
- `<leader>sf` - Find files
- `<leader>sh` - Help tags
- `<leader>sk` - Keymaps
- `<leader>so` - Previously opened files
- `<leader>sg` - Live grep
- `<leader>ss` - Git status
- `<leader>sc` - Spell check suggestions
- `<leader>st` - Todo comments
- `<leader>si` - Picker icons
- `<leader>su` - Picker undo
- `<leader>sr` - GitHub PR picker
- `<leader>sS` - Picker list (all pickers)
- `<leader>/` - Fuzzy search in current buffer
- `<leader><space>` - Find existing buffers

### Spectre (Search & Replace)
- `<leader>S` - Toggle spectre
- `<leader>sw` - Search selected word
- `<leader>sp` - Search in current file

### Buffer (`<leader>b`)
- `<leader>bd` - Delete buffer
- `<leader>bD` - Force delete buffer
- `<leader>ba` - Delete all buffers except current

### File (`<leader>f`)
- `<leader>fp` - Copy file path

### Rename (`<leader>r`)
- `<leader>rn` - Rename symbol

### Maximizer (`<leader>m`)
- `<leader>mm` - Toggle maximizer

### Debug & Trouble (`<leader>d`)
**Trouble:**
- `<leader>dd` - Trouble diagnostics
- `<leader>dx` - Trouble buffer diagnostics
- `<leader>ds` - Trouble symbols
- `<leader>dt` - Trouble todos

**Debug:**
- `<leader>dc` - Debug continue
- `<leader>db` - Debug breakpoint
- `<leader>dr` - Debug REPL
- `<leader>do` - Debug step over
- `<leader>di` - Debug step into
- `<leader>du` - Debug step out
- `<leader>dC` - Debug clear breakpoints
- `<leader>dw` - Debug UI open
- `<leader>dW` - Debug UI close

### Testing (`<leader>t`)
- `<leader>tf` - Test run file
- `<leader>tt` - Test run test
- `<leader>tS` - Test run suite
- `<leader>tl` - Test run last
- `<leader>ts` - Test summary
- `<leader>to` - Test output
- `<leader>tO` - Test output panel
- `<leader>tT` - Test terminate
- `<leader>td` - Debug nearest test
- `<leader>tD` - Debug current file

### Workspace (`<leader>w`)
- `<leader>wa` - Add workspace directory
- `<leader>wr` - Remove workspace directory
- `<leader>wl` - List workspace directories

### Git (`<leader>g`)
- `<leader>gg` - LazyGit
- `<leader>gf` - Git file history
- `<leader>gh` - Git preview hunk
- `<leader>gp` - Git previous hunk
- `<leader>gn` - Git next hunk
- `<leader>gs` - Git stage hunk
- `<leader>gr` - Git reset hunk

---

## Non-Leader Key Bindings

### LSP & Diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `dp` - Open diagnostic in float window
- `gd` - Go to definition
- `gr` - Go to references
- `gI` - Go to implementation
- `gD` - Go to declaration
- `K` - Hover documentation

### Flash (Motion)
- `s` - Flash jump
- `S` - Flash treesitter select

### Folding (`z`)
- `zR` - Open all folds
- `zM` - Close all folds
- `zK` - Peek fold
- `za` - Toggle fold

### Surrounding (`s`)
- `sa` - Add surrounding
- `sd` - Delete surrounding
- `sf` - Find surrounding (right)
- `sF` - Find surrounding (left)
- `sh` - Highlight surrounding
- `sr` - Replace surrounding
- `sn` - Update n lines

### Visual Mode Enhancements
- `p` - Paste without yanking (preserves clipboard)

### Control Keys
- `<C-a>` - Select all

### Buffer Navigation
- `<Tab>` - Next buffer
- `<S-Tab>` - Previous buffer

### Autocompletion (Insert Mode)
- `<C-k>` - Show/hide documentation and signature help
- `<C-j>` - Select next item
- `<C-u>` - Scroll docs up
- `<C-d>` - Scroll docs down
- `<C-s>` - Show/hide completion
- `<C-e>` - Close completion
- `<C-y>` - Confirm selection

### Oil File Explorer
- `<C-s>` - Open in vertical split
- `<C-h>` - Open in horizontal split
- `<C-t>` - Open in new tab
- `<C-p>` - Preview file
- `<C-q>` - Close Oil
- `<leader>q` - Close Oil
- `<C-l>` - Refresh

### Treesitter Context
- `[c` - Go to context
- `]c` - Toggle context

### Treesitter Text Objects

**Movement:**
- `]m` - Next function start
- `[m` - Previous function start
- `]M` - Next function end
- `[M` - Previous function end
- `]]` - Next class start
- `[[` - Previous class start
- `][` - Next class end
- `[]` - Previous class end

**Selection:**
- `aa` - Select parameter (outer)
- `ia` - Select parameter (inner)
- `af` - Select function (outer)
- `if` - Select function (inner)
- `ac` - Select class (outer)
- `ic` - Select class (inner)

**Incremental Selection:**
- `<Tab>` - Expand node selection (in visual mode)
- `<S-Tab>` - Shrink node selection (in visual mode)

### Common Vim Motions & Operators

**Word Movement:**
- `w` - Next word
- `b` - Previous word
- `e` - End of word
- `ge` - End of previous word

**Line Movement:**
- `0` - Beginning of line
- `^` - First non-blank character
- `$` - End of line
- `g_` - Last non-blank character

**Paragraph/Block Movement:**
- `{` - Previous paragraph/block
- `}` - Next paragraph/block

**Search:**
- `/` - Search forward
- `?` - Search backward
- `n` - Next search result
- `N` - Previous search result
- `*` - Search word under cursor forward
- `#` - Search word under cursor backward

**Marks:**
- `m{a-zA-Z}` - Set mark
- `'{a-zA-Z}` - Jump to mark line
- `` `{a-zA-Z}`` - Jump to mark position

**Macros:**
- `q{a-z}` - Start recording macro
- `q` - Stop recording macro
- `@{a-z}` - Play macro
- `@@` - Repeat last macro
