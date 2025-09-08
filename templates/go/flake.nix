{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    # devshells also provided basic langs requirements under dir langs,
    # including go, rust, nodejs and so on.
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
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            baseshell.devShells.${system}.default
          ];

          packages = with pkgs; [
            # install the packages you need
            libiconv
            gcc

            # go contains go and gofmt
            go

            golangci-lint
            gopls
            gotools
            gomodifytags
          ];

          shellHook = ''
            export AU_LANG_GO=1;
          '';
        };
      }
    );
}
