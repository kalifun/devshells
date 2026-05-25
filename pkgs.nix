{ ... }: {
  perSystem = { pkgs, ... }: {
    packages.mkdevshell = pkgs.writeShellScriptBin "mkdevshell" (builtins.readFile ./scripts/mkdevshell);
  };
}
