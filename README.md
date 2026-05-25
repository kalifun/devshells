# devshells

A collection of ready-to-use [Nix devshells](https://github.com/numtide/devshell) for common language toolchains, plus a CLI tool (`mkdevshell`) to quickly set up project shells.

## Quick start

Add one line to your `.envrc`:

```text
use flake github:kalifun/devshells#rust-stable
```

Then `direnv allow`.

### Available shells

| Shell | Description |
|---|---|
| `go-1_24` | Go 1.24 with gopls, delve, golangci-lint |
| `go-1_25` | Go 1.25 with gopls, delve, golangci-lint |
| `go-latest` | Go latest with gopls, delve, golangci-lint |
| `java-android` | Java 17 + Android with Maven, Gradle, ktfmt |
| `lua` | Lua with lua-language-server, stylua |
| `nix` | Nix with alejandra, nil (common base packages) |
| `nodejs-20` | Node.js 20 with yarn, typescript-language-server, prettierd |
| `nodejs-22` | Node.js 22 with yarn, pnpm, typescript-language-server, prettierd |
| `python-311` | Python 3.11 with uv, ruff |
| `python-313` | Python 3.13 with uv, ruff |
| `python-314` | Python 3.14 with uv, ruff |
| `rust-stable` | Rust stable toolchain with rust-analyzer, taplo, cargo-nextest |
| `rust-nightly` | Rust nightly (complete) with gdb, lldb, cargo-nextest |
| `rust-nightly-wasm` | Rust nightly with WASM target support |
| `thrift` | Apache Thrift with thrift-ls |
| `zig` | Zig stable with zls |
| `zig-latest` | Zig master (latest) with zls |

## Tools

### mkdevshell — CLI for managing devshells

Install it as a Nix package and use it to set up project shells.

```bash
# run from flake
nix run github:kalifun/devshells#mkdevshell -- --help

# or add to your system packages
# inputs.devshells.packages.${system}.mkdevshell
```

**Modes:**

| Command | Description |
|---|---|
| `simple <name>` | Generate `.envrc` for a single shell |
| `composite` | Interactive fzf multi-select to combine shells |
| `template [name]` | Initialize a project with `nix flake init` |

**Examples:**

```bash
# single shell
mkdevshell simple rust-stable

# combine multiple shells
mkdevshell composite

# init from template
mkdevshell template rust
```

### Composite shells

Combine any shells without pre-defining combinations:

```nix
# in your flake.nix
(builtins.getFlake "github:kalifun/devshells").compositeShell "x86_64-linux" [
  "rust-stable"
  "nodejs-22"
]
```

Or use `mkdevshell composite` to generate a local `flake.nix` + `.envrc`.

### Templates

Use `nix flake init` to bootstrap a project with a language-specific template:

```bash
nix flake init -t github:kalifun/devshells#rust
```

Available templates: `go`, `lua`, `nodejs`, `plain`, `python`, `rust`, `zig`.

## Flake outputs

- **devShells.`<system>`.`<name>`** — each language shell as a devShell
- **packages.`<system>`.mkdevshell** — the `mkdevshell` CLI tool
- **devshellsIndex** — structured JSON of all shells/templates (for script consumption)
- **compositeShell** — function: `system -> [string] -> derivation` to combine shells
- **templates.`<name>`** — `nix flake init` templates

## Development

```bash
# build all shells (slow first time)
nix build ".#devShells.$(nix eval --raw nixpkgs#system).rust-stable"

# build mkdevshell
nix build ".#packages.$(nix eval --raw nixpkgs#system).mkdevshell"
```
