{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:dustypomerleau/fenix/sdk";
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
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            nativeBuildInputs = [
              fenix.packages.${system}.complete.toolchain
            ];

            env = {
              AU_LANG_RUST = "1";
            };

            packages = [
              taplo
              rust-analyzer-nightly

              pkg-config
              openssl.dev
            ];
          };
      in {
        devShells.default = devShell;
      }
    );
}
