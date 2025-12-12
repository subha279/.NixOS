return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			-- auto start
			autostart = true,
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Python
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,

				-- C, C++
				null_ls.builtins.formatting.clang_format.with({ extra_args = { "-style=file" } }),

				-- Nix
				null_ls.builtins.formatting.nixpkgs_fmt,

				-- JavaScript, TypeScript, JSON, YAML
				null_ls.builtins.formatting.prettier,

				-- Go
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,

				-- Shell scripting (Bash, Zsh)
				null_ls.builtins.formatting.shfmt,

				-- Markdown, HTML, CSS
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.markdownlint,

				-- YAML
				null_ls.builtins.diagnostics.yamllint,

				-- PHP
				null_ls.builtins.formatting.phpcsfixer,
				null_ls.builtins.diagnostics.phpcs,

				-- Java
				null_ls.builtins.formatting.google_java_format,

				-- Terraform
				null_ls.builtins.formatting.terraform_fmt,

				-- CMake
				null_ls.builtins.formatting.cmake_format,

				-- Ruby
				null_ls.builtins.formatting.rubocop,
			},
		})

		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Code Format" })
	end,
}
