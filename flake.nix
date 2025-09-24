{
  description = "A thin wrapper around kotlin-lsp, providing minimal integration with Neovim.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (_: {
      systems = import inputs.systems;
      perSystem =
        {
          self',
          system,
          pkgs,
          lib,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ (import ./nix/plugin-overlay.nix { inherit (inputs) self'; }) ];
          };
          packages.nvim-kotlin-lsp = pkgs.vimUtils.buildVimPlugin {
            name = "nvim-kotlin-lsp";
            src = lib.cleanSource ./.;
          };

          checks = {
            pre-commit-check = inputs.git-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                nixfmt-rfc-style.enable = true;
                statix.enable = true;
                deadnix.enable = true;
                selene.enable = true;
                stylua.enable = true;
              };
            };
          };

          apps = import ./nix/apps { inherit self' pkgs lib; };

          devShells.default = pkgs.mkShell {
            inherit (self'.checks.pre-commit-check) shellHook;
            packages = [ ];
          };
        };
    });
}
