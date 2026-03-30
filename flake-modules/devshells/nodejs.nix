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

        AU_LANG_TS = 1;
        AU_LANG_CSS = 1;
        AU_LANG_HTML = 1;
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

        AU_LANG_TS = 1;
        AU_LANG_CSS = 1;
        AU_LANG_HTML = 1;
      };
    };
  };
}
