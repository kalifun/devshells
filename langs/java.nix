{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: {
    devShells."java-android" = pkgs.mkShell {
      packages =
        basePackages
        ++ (with pkgs; [
          jdk17
          maven
          gradle
          ktfmt
        ]);
    };
  };
}
