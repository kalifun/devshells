{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    baseshell.url = "github:acehinnnqru/devshells?dir=base";
  };

  outputs = { self, nixpkgs, utils, baseshell }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        devShell = with pkgs; mkShell {
          packages = [
            baseshell.devShells.${system}.default

            nil
          ];
        };
      in
      {
        devShells.default = devShell;
      }
    );
}
