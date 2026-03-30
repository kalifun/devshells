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
        ./flake-modules/devshells/common.nix
        ./flake-modules/devshells/go.nix
        ./flake-modules/devshells/lua.nix
        ./flake-modules/devshells/nix.nix
        ./flake-modules/devshells/nodejs.nix
        ./flake-modules/devshells/python.nix
        ./flake-modules/devshells/rust.nix
        ./flake-modules/devshells/thrift.nix
        ./flake-modules/devshells/zig.nix
        ./flake-modules/devshells/default.nix
      ];
    };
}
