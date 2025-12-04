{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    baseshell = {
      url = "github:acehinnnqru/devshells?dir=base";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };

    nixpkgs_with_go124.url = "github:NixOS/nixpkgs/418468ac9527e799809c900eda37cbff999199b6";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    baseshell,
    nixpkgs_with_go124,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs_with_go124 = import nixpkgs_with_go124 {
          inherit system;
        };
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            packages =
              [
                libiconv
                gcc

                golangci-lint
                gotools
                gomodifytags
              ]
              ++ (
                with pkgs_with_go124; [
                  # go contains go and gofmt
                  go_1_24
                  gopls
                ]
              );

            AU_LANG_GO = "1";
          };
      in {
        devShells.default = devShell;
      }
    );
}
