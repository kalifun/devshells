{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
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
    baseshell,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        devShell = with pkgs;
          mkShell {
            inputsFrom = [
              baseshell.devShells.${system}.default
            ];

            packages = [
              python313

              uv
              ruff
              ty
            ];

            UV_PYTHON_DOWNLOADS = "never";
          };
      in {
        devShells.default = devShell;
      }
    );
}
