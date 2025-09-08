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
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            baseshell.devShells.${system}.default
          ];
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

          shellHook = ''
            export AU_LANG_RUST=1;
            echo "进入增强开发环境"
          '';
        };
      }
    );
}
