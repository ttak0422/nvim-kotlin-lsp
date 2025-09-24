vim.lsp.config("kotlin_lsp", {
  filetypes = { "kotlin" },
  cmd = { "kotlin-lsp", "--stdio" },
  root_markers = {
    "settings.gradle",
    "settings.gradle.kts",
    "pom.xml",
    "build.gradle",
    "build.gradle.kts",
    "workspace.json",
  },
})

vim.lsp.enable({ "kotlin_lsp" })
