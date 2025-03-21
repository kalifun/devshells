{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        devShell = with pkgs;
          mkShell {
            packages =
              [
                ## basic pkgs
                tree-sitter

                gcc

                cmake
                ninja

                clang-tools

                # lang
                lua
                luajit
                # formatter
                stylua
                # lsp
                lua-language-server
              ]
              ++ lib.optionals stdenv.isDarwin (with darwin;
                with apple_sdk.frameworks; [
                  libiconv
                  libresolv
                  Libsystem
                  SystemConfiguration
                  Security
                  CoreFoundation
                ]);

            AU_LANG_LUA = "1";
            AU_LANG_C = "1";
          };
      in {
        devShells.default = devShell;
      }
    );
}
