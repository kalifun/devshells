{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    # devshells also provided basic langs requirements under dir langs,
    # including go, rust, nodejs and so on.
    baseshell = {
      url = "github:acehinnnqru/devshells?dir=base";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    baseshell,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            baseshell.devShells.${system}.default
          ];
          packages = [
            # install the packages you need
            python311

            uv
            ruff
            ty
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
