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
      };
    };
  };
}
