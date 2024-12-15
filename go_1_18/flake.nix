{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    nixpkgs_with_go118.url = "github:NixOS/nixpkgs/517501bcf14ae6ec47efd6a17dda0ca8e6d866f9";
  };

  outputs = { self, nixpkgs, utils, nixpkgs_with_go118 }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs_with_go118 = import nixpkgs_with_go118 {
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
                gopls
              ]
            )
            ;
        };
      }
    );
}
