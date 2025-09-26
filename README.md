# nvim-kotlin-lsp

[![Nix Flake Checks](https://github.com/ttak0422/nvim-kotlin-lsp/actions/workflows/nix-flake-check.yml/badge.svg)](https://github.com/ttak0422/nvim-kotlin-lsp/actions/workflows/nix-flake-check.yml)

A Neovim companion plugin that provides additional functionality for [`kotlin-lsp`](https://github.com/Kotlin/kotlin-lsp) beyond what the language server itself provides.

## Features

This plugin currently implements a small subset of the functionality available in the `kotlin-vscode` that ships with [`kotlin-lsp`](https://github.com/Kotlin/kotlin-lsp/tree/main/kotlin-vscode).

- `decompile` command for opening `jar://` URI 
- `exportWorkspace` command for writing `workspace.json` 

## Usage

Once installed, the plugin integrates seamlessly with your existing kotlin-lsp configuration and enhances your development workflow automatically.

## Development (Optional Nix Workflow)

This repository includes a Nix-based development setup, but **Nix is completely optional** for using the plugin:

- `nix develop` - Enter development shell with formatting and lint hooks
- `nix run .#minimal` - Launch standalone Neovim with this plugin for testing
