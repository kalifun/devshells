{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: {
    devShells.lua = pkgs.mkShell {
      packages =
        basePackages
        ++ (with pkgs; [
          lua
          stylua
          lua-language-server
        ]);
    };
  };
}
