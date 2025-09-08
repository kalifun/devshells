{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    baseshell = {
      url = "github:acehinnnqru/devshells?dir=base";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
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
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            packages = [
              libiconv
              gcc

              # basic
              nodejs_20
              yarn

              ## lsp
              # lsp for ts
              typescript-language-server
              # lsp for json, markdown, css, html, eslint
              vscode-langservers-extracted

              # formatter
              prettierd
            ];

            AU_LANG_TS = 1;
            AU_LANG_CSS = 1;
            AU_LANG_HTML = 1;
          };
      in {
        devShells.default = devShell;
      }
    );
}
