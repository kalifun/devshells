{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    devshells = {
      url = "github:acehinnnqru/devshells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    utils,
    devshells,
    fenix,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [fenix.overlays.default];
        };

        # wasmToolchain = with fenix.packages.${system};
        #   combine [
        #     complete.toolchain
        #     targets.wasm32-unknown-unknown.latest.rust-std
        #   ];
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            # fenix.packages.${system}.stable.toolchain
            # fenix.packages.${system}.complete.toolchain
            devshells.devShells.${system}."nix"
          ];
          packages = with pkgs; [
            # install the packages you need
            # ripgrep
            cargo-nextest
            taplo

            # rust-analyzer-nightly
            # rust-analyzer
          ];

          RUST_BACKTRACE = 1;

          shellHook = ''
            echo "enter custom devshells"
          '';
        };
      }
    );
}
