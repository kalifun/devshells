{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    nixpkgs_with_go120.url = "github:NixOS/nixpkgs/a343533bccc62400e8a9560423486a3b6c11a23b";
  };

  outputs = { self, nixpkgs, utils, nixpkgs_with_go120 }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs_with_go120 = import nixpkgs_with_go120 {
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
              with pkgs_with_go120; [
                # go contains go and gofmt
                go_1_20
                gopls
              ]
            )
            ;
        };
      }
    );
}
