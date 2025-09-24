if vim.g.nvim_kotlin_lsp then
  return
end
vim.g.nvim_kotlin_lsp = 1

local group = vim.api.nvim_create_augroup("kotlin-lsp", { clear = true })
vim.api.nvim_create_autocmd("BufReadCmd", {
  group = group,
  pattern = "jar://*",
  --- @param args vim.api.keyset.create_autocmd.callback_args
  callback = function(args)
    require("kotlin-lsp").open_decompiled_file(args.match)
  end,
})
