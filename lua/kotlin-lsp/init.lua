local M = {}

--- @param fname string
function M.open_decompiled_file(fname)
  require("kotlin-lsp.commands.decompile").open_decompiled_file(fname)
end

return M
