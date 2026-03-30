{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    basePackages,
    ...
  }: let
    pkgsGo124 = import inputs.nixpkgs-go124 {inherit system;};
    pkgsGo125 = import inputs.nixpkgs-go125 {inherit system;};

    goCommonPackages = with pkgs; [
      libiconv
      gcc
      golangci-lint
      gotools
      gomodifytags
    ];
  in {
    devShells = {
      "go-latest" = pkgs.mkShell {
        packages =
          basePackages
          ++ goCommonPackages
          ++ (with pkgs; [
            go
            gopls
            delve
          ]);
      };

      "go-1_25" = pkgs.mkShell {
        packages =
          basePackages
          ++ goCommonPackages
          ++ (with pkgsGo125; [
            go_1_25
            gopls
          ]);
      };

      "go-1_24" = pkgs.mkShell {
        packages =
          basePackages
          ++ goCommonPackages
          ++ (with pkgsGo124; [
            go_1_24
            gopls
          ]);

        AU_LANG_GO = "1";
      };
    };
  };
}
