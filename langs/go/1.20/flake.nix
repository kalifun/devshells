{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    baseshell = {
      url = "github:acehinnnqru/devshells?dir=base";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    nixpkgs_with_go120.url = "github:NixOS/nixpkgs/a343533bccc62400e8a9560423486a3b6c11a23b";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    baseshell,
    nixpkgs_with_go120,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs_with_go120 = import nixpkgs_with_go120 {
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

                golangci-lint
                gotools
                gomodifytags
              ]
              ++ (
                with pkgs_with_go120; [
                  # go contains go and gofmt
                  go_1_20
                  gopls
                ]
              );

            AU_LANG_GO = "1";
          };
      }
    );
}
