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
      in {
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            packages = [
              libiconv
              gcc

              # go contains go and gofmt
              go_1_21

              golangci-lint
              gopls
              gotools
              gomodifytags
            ];

            AU_LANG_GO = "1";
          };
      }
    );
}
