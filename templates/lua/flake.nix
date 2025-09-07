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
        devShells.default = pkgs.mkShell (
          pkgs.lib.mkMerge [
            baseshell.devShells.${system}.default

            {
              packages = with pkgs; [
                # install the packages you need
                lua
                # formatter
                stylua
                # lsp
                lua-language-server
              ];

              # set your own envs

              AU_LANG_LUA = 1;

              shellHook = pkgs.lib.mkOptionDefault (
                (baseshell.devShells.${system}.default.shellHook or "")
                + ''
                  echo "enter custom devshells"
                ''
              );
            }
          ]
        );
      }
    );
}
