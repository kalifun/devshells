{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: {
    devShells.nix = pkgs.mkShell {
      packages = basePackages;
    };
  };
}
