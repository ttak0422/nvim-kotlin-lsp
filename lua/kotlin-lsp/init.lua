local M = {}

--- @param fname string
function M.open_decompiled_file(fname)
  require("kotlin-lsp.commands.decompile").open_decompiled_file(fname)
end

function M.export_workspace()
  require("kotlin-lsp.commands.jetbrains").export_workspace()
end

return M
