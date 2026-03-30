{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: let
    inherit (pkgs) lib stdenv darwin;
  in {
    devShells.neovim = pkgs.mkShell {
      packages =
        basePackages
        ++ (with pkgs; [
          tree-sitter
          gcc
          cmake
          ninja
          clang-tools
          lua
          luajit
          stylua
          lua-language-server
        ])
        ++ lib.optionals stdenv.isDarwin (with darwin;
          with apple_sdk.frameworks; [
            libiconv
            libresolv
            Libsystem
            SystemConfiguration
            Security
            CoreFoundation
          ]);
    };
  };
}
