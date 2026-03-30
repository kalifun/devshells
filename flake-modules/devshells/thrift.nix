{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: {
    devShells.thrift = pkgs.mkShell {
      packages =
        basePackages
        ++ (with pkgs; [
          thrift-ls
        ]);

      AU_LANG_THRIFT = "1";
    };
  };
}
