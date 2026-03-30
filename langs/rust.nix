{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    basePackages,
    ...
  }: let
    pkgsWithFenix = import inputs.nixpkgs {
      inherit system;
      overlays = [inputs.fenix.overlays.default];
    };

    wasmToolchain = with inputs.fenix.packages.${system};
      combine [
        complete.toolchain
        targets.wasm32-unknown-unknown.latest.rust-std
      ];
  in {
    devShells = {
      "rust-stable" = pkgsWithFenix.mkShell {
        packages =
          basePackages
          ++ (with pkgsWithFenix; [
            libiconv
            gcc
            rust-analyzer
            llvmPackages.bintools
          ]);

        nativeBuildInputs = [
          inputs.fenix.packages.${system}.stable.toolchain
        ];
      };

      "rust-nightly" = pkgsWithFenix.mkShell {
        packages =
          basePackages
          ++ (with pkgsWithFenix; [
            taplo
            rust-analyzer-nightly
            pkg-config
            openssl.dev
          ]);

        nativeBuildInputs = [
          inputs.fenix.packages.${system}.complete.toolchain
        ];
      };

      "rust-nightly-wasm" = pkgsWithFenix.mkShell {
        packages =
          basePackages
          ++ (with pkgsWithFenix; [
            taplo
            libiconv
            gcc
            rust-analyzer-nightly
          ]);

        nativeBuildInputs = [
          wasmToolchain
        ];
      };
    };
  };
}
