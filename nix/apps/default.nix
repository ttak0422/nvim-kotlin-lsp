{
  self',
  pkgs,
  lib,
  ...
}:
{
  minimal =
    let
      config = pkgs.neovimUtils.makeNeovimConfig {
        customLuaRC = builtins.readFile ./init.lua;
        plugins = [ { plugin = self'.packages.nvim-kotlin-lsp; } ];
      };

      neovim =
        with pkgs;
        wrapNeovimUnstable neovim-unwrapped (
          config
          // {
            wrapperArgs =
              (lib.escapeShellArgs config.wrapperArgs)
              + " --suffix PATH : \"${lib.makeBinPath [ pkgs.kotlin-lsp ]}\"";
          }
        );
    in
    {
      type = "app";
      program = lib.getExe neovim;
    };
}
