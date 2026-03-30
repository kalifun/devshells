{...}: {
  perSystem = {
    pkgs,
    basePackages,
    ...
  }: {
    devShells = {
      "nodejs-20" = pkgs.mkShell {
        packages =
          basePackages
          ++ (with pkgs; [
            libiconv
            gcc
            nodejs_20
            yarn
            typescript-language-server
            vscode-langservers-extracted
            prettierd
          ]);
      };

      "nodejs-22" = pkgs.mkShell {
        packages =
          basePackages
          ++ (with pkgs; [
            libiconv
            gcc
            nodejs_22
            yarn
            pnpm
            typescript-language-server
            vscode-langservers-extracted
            prettierd
          ]);
      };
    };
  };
}
