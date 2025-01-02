{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    baseshell.url = "github:acehinnnqru/devshells?dir=base";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    baseshell,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            packages = [
              # lang
              lua
              # formatter
              stylua
              # lsp
              lua-language-server
            ];

            AU_LANG_LUA = "1";
          };
      }
    );
}
