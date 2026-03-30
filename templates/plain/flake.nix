{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    devshells = {
      url = "github:acehinnnqru/devshells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    utils,
    devshells,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            devshells.devShells.${system}.default
          ];

          packages = with pkgs; [
            # install the packages you need
          ];

          shellHook = ''
            echo "enter custom devshells"
          '';
        };
      }
    );
}
