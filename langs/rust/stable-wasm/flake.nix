{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    baseshell.url = "github:acehinnnqru/devshells?dir=base";
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
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            AU_LANG_RUST = "1";

            packages = [
              libiconv
              gcc

              (with fenix.packages."${system}";
                combine [
                  stable.cargo
                  stable.clippy
                  stable.rust-src
                  stable.rustc
                  stable.rustfmt
                  targets.wasm32-wasi.stable.rust-std
                ])

              rust-analyzer
              wasmedge
            ];
          };
      }
    );
}
