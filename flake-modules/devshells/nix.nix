{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: {
    devShells.nix = pkgs.mkShell {
      packages = basePackages;

      shellHook = ''
        export AU_LANG_NIX=1
      '';
    };
  };
}
