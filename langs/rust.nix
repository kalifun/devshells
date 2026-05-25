{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    basePackages,
    baseShellHook,
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

    rustShellHook = baseShellHook + ''
      echo initing rust env
      rustc --version
      cargo --version
      export PATH=$PATH:~/.cargo/bin
      echo loaded rust env
    '';
  in {
    devShells = {
      "rust-stable" = pkgsWithFenix.mkShell {
        packages =
          basePackages
          ++ (with pkgsWithFenix; [
            taplo
            rust-analyzer
            gcc
            lldb
            pkg-config

            libiconv

            cargo-nextest
          ]);

        nativeBuildInputs = [
          inputs.fenix.packages.${system}.stable.toolchain
        ];

        shellHook = rustShellHook;

        RUST_BACKTRACE = 1;
      };

      "rust-nightly" = pkgsWithFenix.mkShell {
        packages =
          basePackages
          ++ (with pkgsWithFenix; [
            taplo
            gcc
            lldb
            gdb
            pkg-config

            libiconv

            cargo-nextest
          ]);

        nativeBuildInputs = [
          inputs.fenix.packages.${system}.complete.toolchain
        ];

        shellHook = rustShellHook;

        RUST_BACKTRACE = 1;
      };

      "rust-nightly-wasm" = pkgsWithFenix.mkShell {
        packages =
          basePackages
          ++ (with pkgsWithFenix; [
            taplo
            rust-analyzer-nightly
            gcc
            lldb
            pkg-config

            libiconv

            cargo-nextest
          ]);

        nativeBuildInputs = [
          wasmToolchain
        ];

        shellHook = rustShellHook;

        RUST_BACKTRACE = 1;
      };
    };
  };
}
