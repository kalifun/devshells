{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    devshells = {
      url = "github:kalifun/devshells";
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
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [fenix.overlays.default];
      };
    in {
      devShells.default = pkgs.mkShell {
        inputsFrom = [
          devshells.devShells.${system}."nix"
        ];

        packages = with pkgs; [
          cargo-nextest
          taplo
        ];

        RUST_BACKTRACE = 1;

        shellHook = ''
          echo "enter custom devshells"
        '';
      };
    });
}
