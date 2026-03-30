{
  description = "Language-focused development shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zig-overlay.url = "github:mitchellh/zig-overlay";

    nixpkgs-go125.url = "github:NixOS/nixpkgs/09061f748ee21f68a089cd5d91ec1859cd93d0be";
    nixpkgs-go124.url = "github:NixOS/nixpkgs/418468ac9527e799809c900eda37cbff999199b6";
  };

  outputs = inputs @ {
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        ./flake-modules/common.nix
        ./flake-modules/langs/go.nix
        ./flake-modules/langs/lua.nix
        ./flake-modules/langs/nix.nix
        ./flake-modules/langs/nodejs.nix
        ./flake-modules/langs/python.nix
        ./flake-modules/langs/rust.nix
        ./flake-modules/langs/thrift.nix
        ./flake-modules/langs/zig.nix
        ./flake-modules/langs/default.nix
      ];
    };
}
