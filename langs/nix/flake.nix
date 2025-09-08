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
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell (
          pkgs.lib.mkMerge [
            baseshell.devShells.${system}.default

            {
              packages = with pkgs; [
                alejandra
                nil
              ];

              AU_LANG_NIX = "1";

              shellHook = pkgs.lib.mkOptionDefault (
                (baseshell.devShells.${system}.default.shellHook or "")
                + ''
                  echo "devshells for nix"
                ''
              );
            }
          ]
        );
      }
    );
}
