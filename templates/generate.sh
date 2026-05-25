#!/usr/bin/env bash
# Regenerate all template flake.nix files from base/flake.nix.in
# Usage: ./templates/generate.sh
set -euo pipefail

cd "$(dirname "$0")"

flake_url="github:kalifun/devshells"
template_src=$(cat base/flake.nix.in)

declare -A templates=(
  [plain]="simple:default|plain|||"
  [go]="simple:go-latest|||"
  [lua]="simple:lua|||"
  [zig]="simple:zig|||"
  [nodejs]="simple:nodejs-22|||"
  [python]="simple:python-313||UV_PYTHON_DOWNLOADS = \"never\";|# [ -d \".venv\" ] && echo \".venv exists\" || { echo -e \"\\033[31m.venv not exists...\\033[0m\"; echo \"creating ...\"; uv venv .venv; }\n# [ -d \".venv\" ] && { source ./.venv/bin/activate; echo \"enter .venv\" } || true"
  [rust]="rust:nix|fenix = {\n  url = \"github:nix-community/fenix\";\n  inputs.nixpkgs.follows = \"nixpkgs\";\n};|fenix,|overlays = [fenix.overlays.default];|  cargo-nextest\n  taplo|  RUST_BACKTRACE = 1;|"
)

for name in "${!templates[@]}"; do
  IFS='|' read -r type shell extra_inputs extra_output_args extra_overlay extra_packages extra_env extra_shellhook <<< "${templates[$name]}"

  mkdir -p "$name"

  content="$template_src"
  content="${content//@flakeUrl@/$flake_url}"
  content="${content//@shell@/$shell}"
  content="${content//@extraInputs@/$extra_inputs}"
  content="${content//@extraOutputArgs@/$extra_output_args}"
  content="${content//@extraPkgsOverlay@/$extra_overlay}"
  content="${content//@extraPackages@/$extra_packages}"
  content="${content//@envBlock@/$extra_env}"
  content="${content//@extraShellHook@/$extra_shellhook}"

  echo "$content" > "$name/flake.nix"
  echo "Generated $name/flake.nix"
done
