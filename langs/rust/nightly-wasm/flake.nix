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
        toolchain = with fenix.packages.${system};
          combine [
            complete.toolchain
            targets.wasm32-unknown-unknown.latest.rust-std
          ];
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];
            nativeBuildInputs = [
              toolchain
            ];

            env = {
              AU_LANG_RUST = "1";
            };

            packages = [
              taplo
              libiconv
              gcc
              rust-analyzer-nightly
            ];
          };
      in {
        devShells.default = devShell;
      }
    );
}
