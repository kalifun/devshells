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
              pkgs.pkgsCross.x86_64-darwin.libiconv
            ];

            packages = [
              (
                with fenix.packages.${system};
                  combine [
                    stable.toolchain
                    targets.x86_64-apple-darwin.stable.rust-std
                  ]
              )

              libiconv
              gcc
              rust-analyzer
              llvmPackages.bintools
            ];

            shellHook = ''
              export RUSTFLAGS="-L ${pkgs.pkgsCross.x86_64-darwin.libiconv}/lib $RUSTFLAGS";
            '';
            AU_LANG_RUST = "1";
            CARGO_TARGET_X86_64_APPLE_DARWIN_LINKER = "lld";
          };
      }
    );
}
