{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        devShell = with pkgs; mkShell {
          buildInputs = [
            ## basic pkgs
            tree-sitter

            ## basic lsp
            # lsp for yaml
            yaml-language-server
            # lsp for markdown
            marksman
            # lsp for json, markdown, css, html, eslint
            vscode-langservers-extracted

          ] ++ lib.optionals stdenv.isDarwin (with darwin;
            with apple_sdk.frameworks; [
              libiconv
              libresolv
              Libsystem
              SystemConfiguration
              Security
              CoreFoundation
            ]);
        };
      in
      {
        devShells.default = devShell;
      }
    );
}
