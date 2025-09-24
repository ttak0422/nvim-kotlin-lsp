local M = {}

--- @class nvim-kotlin-lsp.SearchClientOpts
--- @field prev_bufnr integer
--- @field cur_bufnr integer
--- @field timeout_ms integer?

local default_timeout_ms = 5000

--- Get the first client that matchesthe condition
--- @param opts nvim-kotlin-lsp.SearchClientOpts
--- @return vim.lsp.Client?
function M.get_client(opts)
  local client = vim.lsp.get_clients({
    name = "kotlin-lsp",
    bufnr = opts.prev_bufnr,
  })[1] or vim.lsp.get_clients({ name = "kotlin_lsp" })[1]

  if client then
    return client
  end

  vim.wait(opts.timeout_ms or default_timeout_ms, function()
    return next(
      vim.lsp.get_clients({ name = "kotlin_lsp", bufnr = opts.cur_bufnr })
    ) ~= nil
  end)

  return vim.lsp.get_clients({ name = "kotlin_lsp", bufnr = opts.cur_bufnr })[1]
end

return M
