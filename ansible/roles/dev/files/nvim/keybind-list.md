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
- `<leader>x` - Close buffer
- `<leader>u` - Undotree
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

### Go to Preview (`<leader>k`)
- `<leader>kk` - Definition preview window
- `<leader>kq` - Close preview windows
- `<leader>kt` - Type definition preview window
- `<leader>kr` - References preview window
- `<leader>ki` - Implementation preview window

### Search & Telescope (`<leader>s`)
- `<leader>sf` - Find files
- `<leader>sh` - Help tags
- `<leader>sk` - Keymaps
- `<leader>so` - Previously opened files
- `<leader>sg` - Live grep
- `<leader>ss` - Git status
- `<leader>sc` - Spell check suggestions
- `<leader>st` - Todo comments
- `<leader>/` - Fuzzy search in current buffer
- `<leader><space>` - Find existing buffers

### Spectre (Search & Replace)
- `<leader>S` - Toggle spectre
- `<leader>sw` - Search selected word
- `<leader>sp` - Search in current file

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

**Debug:**
- `<leader>dc` - Debug continue
- `<leader>db` - Debug breakpoint
- `<leader>dr` - Debug REPL
- `<leader>dw` - Debug UI open
- `<leader>dW` - Debug UI close

### Testing (`<leader>t`)
- `<leader>tf` - Test run file
- `<leader>tt` - Test run test
- `<leader>tS` - Test run suite
- `<leader>tl` - Test run last
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

### Control Keys
- `<C-k>` - Toggle LSP signature help
