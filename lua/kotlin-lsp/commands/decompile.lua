local M = {}

local utils = require("kotlin-lsp.utils")

--- @class nvim-kotlin-lsp.DecompoleResponse
--- @field code string
--- @field language "kotlin" | "java"

local decompile_timeout_ms = 5000

--- @param fname string
function M.open_decompiled_file(fname)
  -- TODO: Enhance support for when the filetype is java
  local uri
  if vim.startswith(fname, "jar://") then
    uri = fname
  else
    return
  end

  local buf = vim.api.nvim_get_current_buf()

  vim.bo[buf].modifiable = true
  vim.bo[buf].swapfile = false
  vim.bo[buf].buftype = "nofile"

  local client = utils.get_client({
    cur_bufnr = buf,
    prev_bufnr = vim.fn.bufnr("#", -1),
  })

  assert(client, "Must have a `kotlin-lsp` client to load jar uri")

  local done = false

  client:exec_cmd(
    { title = "decompile", command = "decompile", arguments = { uri } },
    { bufnr = buf },
    --- @param err lsp.ResponseError
    --- @param result nvim-kotlin-lsp.DecompoleResponse?
    function(err, result)
      assert(not err, vim.inspect(err))
      assert(result, "kotlin-lsp client must return result for decompile")

      vim.bo[buf].filetype = result.language
      if result.language == "kotlin" then
        vim.lsp.buf_attach_client(buf, client.id)
      end
      local source_lines = vim.split(result.code, "\n", { plain = true })
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, source_lines)
      vim.bo[buf].modifiable = false

      done = true
    end
  )

  -- Need to block. to prevent `Cursor position outside buffer`
  vim.wait(decompile_timeout_ms, function()
    return done
  end)
end

return M
