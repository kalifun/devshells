{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    basePackages,
    ...
  }: {
    devShells = {
      zig = pkgs.mkShell {
        packages =
          basePackages
          ++ (with pkgs; [
            zls
            zig
          ]);

        AU_LANG_ZIG = "1";
      };

      "zig-latest" = pkgs.mkShell {
        packages =
          basePackages
          ++ (with pkgs; [
            zls
          ])
          ++ [
            inputs.zig-overlay.packages.${system}.master
          ];

        AU_LANG_ZIG = "1";
      };
    };
  };
}
