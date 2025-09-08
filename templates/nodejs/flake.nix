{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    # devshells also provided basic langs requirements under dir langs,
    # including go, rust, nodejs and so on.
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
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            baseshell.devShells.${system}.default
          ];
          packages = with pkgs; [
            # install the packages you need
            nodejs_22
            yarn
            pnpm

            ## lsp
            # lsp for ts
            typescript-language-server
            # lsp for json, markdown, css, html, eslint
            vscode-langservers-extracted

            # formatter
            prettierd
          ];

          shellHook = ''
            export AU_LANG_TS=1;
            export AU_LANG_CSS=1;
            export AU_LANG_HTML=1;
            echo "enter custom devshells"
          '';
        };
      }
    );
}
