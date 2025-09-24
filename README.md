# nvim-kotlin-lsp

A Neovim companion plugin that extends [`kotlin-lsp`](https://github.com/fwcd/kotlin-language-server) functionality beyond what `kotlin-lsp --stdio` provides out of the box. The primary feature is automatic decompilation of `jar://` URIs when navigating through LSP symbols.

## What This Plugin Adds

- **Jar Decompilation**: Automatically decompiles and displays source code when you navigate to symbols defined in dependency jars
- **Seamless Integration**: Decompiled buffers maintain syntax highlighting and LSP features when possible
- **Read-only Protection**: Decompiled sources are automatically set as non-modifiable to prevent accidental edits

## Installation

Add the plugin to your Neovim configuration. For example, with Lazy.nvim:

```lua
require("lazy").setup({
  { "ttak0422/nvim-kotlin-lsp" },
})
```

## Usage

Once installed, the plugin works automatically:

1. Ensure your `kotlin-lsp` server is properly configured and running
2. Navigate to any symbol defined in a jar dependency (using `gd`, `K`, etc.)
3. The plugin will intercept `jar://` URIs and display the decompiled source

**Note**: Your kotlin-lsp server must have access to the jar files (typically through Gradle/Maven dependency resolution) for decompilation to work.

## Troubleshooting

- **Blank decompiled buffer**: Confirm the `kotlin-lsp` client is attached using `:LspInfo` before reopening the jar location
- **Missing symbols**: Ensure your project's build tool (Gradle/Maven) has resolved dependencies and they're accessible to the language server

## Development (Optional Nix Workflow)

This repository includes a Nix-based development setup, but **Nix is completely optional** for using the plugin:

- `nix develop` - Enter development shell with formatting and lint hooks
- `nix run .#minimal` - Launch standalone Neovim with this plugin for testing
