{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    devshells = {
      url = "github:acehinnnqru/devshells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    utils,
    devshells,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            devshells.devShells.${system}."python-313"
          ];
          packages = with pkgs; [
            # install the packages you need
            # ripgrep
          ];

          shellHook = ''
            echo "enter custom devshells"

            export UV_PYTHON_DOWNLOADS=never
            # [ -d ".venv" ] && echo ".venv exists" || { echo -e "\033[31m.venv not exists...\033[0m"; echo "creating ..."; uv venv .venv; }

            # [ -d ".venv" ] && { source ./.venv/bin/activate; echo "enter .venv" } || true
          '';
        };
      }
    );
}
