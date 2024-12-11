{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    nixpkgs_with_go118.url = "github:NixOS/nixpkgs/517501bcf14ae6ec47efd6a17dda0ca8e6d866f9";
    nixpkgs_with_gopls.url = "github:NixOS/nixpkgs/9a9dae8f6319600fa9aebde37f340975cab4b8c0";
  };

  outputs = { self, nixpkgs, utils, nixpkgs_with_go118, nixpkgs_with_gopls }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs_with_go118 = import nixpkgs_with_go118 {
          inherit system;
        };
        pkgs_with_gopls = import nixpkgs_with_gopls {
          inherit system;
        };
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            libiconv
            gcc

            golangci-lint
            gotools
          ] ++ lib.optionals stdenv.isDarwin (with darwin;
            with apple_sdk.frameworks; [
              libiconv
              libresolv
              Libsystem
              SystemConfiguration
              Security
              CoreFoundation
            ])
            ++ (
              with pkgs_with_go118; [
                # go contains go and gofmt
                go_1_18
              ]
            )
            ++ (
              with pkgs_with_gopls; [
                gopls
              ]
            )
            ;
        };
      }
    );
}
