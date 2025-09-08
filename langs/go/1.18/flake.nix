{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    baseshell = {
      url = "github:acehinnnqru/devshells?dir=base";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    nixpkgs_with_go118.url = "github:NixOS/nixpkgs/517501bcf14ae6ec47efd6a17dda0ca8e6d866f9";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    baseshell,
    nixpkgs_with_go118,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs_with_go118 = import nixpkgs_with_go118 {
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
                with pkgs_with_go118; [
                  # go contains go and gofmt
                  go_1_18
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
