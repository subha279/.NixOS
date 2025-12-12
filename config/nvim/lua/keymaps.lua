vim.g.mapleader = " "

local keymap = vim.keymap

local opts = { noremap = true, silent = true }

-- Others
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Line Up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Line Down" })
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("x", "<leader>p", [["_dP]])
keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Rename Same Many Words Together In the Cursor" }
)
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.dots/Scripts/tmux-sessionizer<CR>")

-- Pane and Window Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate Right

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split Vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts)  -- Split Horizontally

-- make a file executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
