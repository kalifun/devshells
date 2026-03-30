{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: {
    devShells = {
      "python-311" = pkgs.mkShell {
        packages =
          basePackages
          ++ (with pkgs; [
            python311
            uv
            ruff
            ty
          ]);

        UV_PYTHON_DOWNLOADS = "never";
      };

      "python-313" = pkgs.mkShell {
        packages =
          basePackages
          ++ (with pkgs; [
            python313
            uv
            ruff
            ty
          ]);

        UV_PYTHON_DOWNLOADS = "never";
      };
    };
  };
}
