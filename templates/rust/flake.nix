{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    fenix,
    baseshell,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [fenix.overlays.default];
        };
      in {
        devShells.default = pkgs.mkShell (
          pkgs.lib.mkMerge [
            baseshell.devShells.${system}.default
            {
              packages = with pkgs; [
                (
                  with fenix.packages.${system};
                    combine [
                      stable.toolchain
                    ]
                )

                libiconv
                gcc
                rust-analyzer
                llvmPackages.bintools
              ];

              AU_LANG_RUST = "1";
              shellHook = pkgs.lib.mkOptionDefault (
                (baseshell.devShells.${system}.default.shellHook or "")
                + ''
                  echo "进入增强开发环境"
                ''
              );
            }
          ]
        );
      }
    );
}
