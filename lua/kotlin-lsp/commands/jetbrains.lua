local M = {}

local utils = require("kotlin-lsp.utils")

function M.export_workspace()
  local buf = vim.api.nvim_get_current_buf()
  local client = utils.get_client({
    cur_bufnr = buf,
    prev_bufnr = vim.fn.bufnr("#", -1),
  })

  assert(client, "Must have a `kotlin-lsp` client to export workspace")

  local root_dir = client.config.root_dir

  client:exec_cmd({
    title = "exportWorkspace",
    command = "exportWorkspace",
    arguments = { root_dir },
  }, { bufnr = buf }, function()
    vim.notify("Exported workspace structure to workspace.json.")
  end)
end

return M
