{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        devShell = with pkgs;
          mkShell {
            packages = [
              ## basic pkgs
              tree-sitter

              ## basic lsp
              # lsp for yaml
              yaml-language-server
              # lsp for markdown
              marksman
              # lsp for json, markdown, css, html, eslint
              vscode-langservers-extracted

              alejandra
              nil
            ];

            shellHook = ''
              export AU_LANG_NIX=1;
            '';
          };
      in {
        devShells.default = devShell;
      }
    );
}
