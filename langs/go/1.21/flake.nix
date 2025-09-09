{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    baseshell = {
      url = "github:acehinnnqru/devshells?dir=base";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    nixpkgs_with_go121.url = "github:NixOS/nixpkgs/5ed627539ac84809c78b2dd6d26a5cebeb5ae269";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    baseshell,
    nixpkgs_with_go121,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs_with_go121 = import nixpkgs_with_go121 {
          inherit system;
        };
      in {
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            packages =
              [
                libiconv
                gcc

                # go contains go and gofmt
                golangci-lint
                gotools
                gomodifytags
              ]
              ++ (
                with pkgs_with_go121; [
                  go_1_21
                  gopls
                ]
              );

            AU_LANG_GO = "1";
          };
      }
    );
}
