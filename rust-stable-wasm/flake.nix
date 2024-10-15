{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, fenix }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlays.default ];
        };
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            libiconv
            gcc

            (with fenix.packages."${system}"; combine [
              stable.cargo
              stable.clippy
              stable.rust-src
              stable.rustc
              stable.rustfmt
              targets.wasm32-wasi.stable.rust-std
            ])

            rust-analyzer
            wasmedge
          ] ++ lib.optionals stdenv.isDarwin (with darwin;
            with apple_sdk.frameworks; [
              libiconv
              libresolv
              Libsystem
              SystemConfiguration
              Security
              CoreFoundation
            ]);
        };
      }
    );
}
