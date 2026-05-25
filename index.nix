{
  flake.devshellsIndex = {
    simple = {
      rust-stable = {
        description = "Rust stable toolchain with rust-analyzer, taplo, cargo-nextest";
      };
      rust-nightly = {
        description = "Rust nightly (complete) with gdb, lldb, cargo-nextest";
      };
      rust-nightly-wasm = {
        description = "Rust nightly with WASM target support";
      };
      go-latest = {
        description = "Go latest with gopls, delve, golangci-lint";
      };
      go-1_25 = {
        description = "Go 1.25 with gopls, delve, golangci-lint";
      };
      go-1_24 = {
        description = "Go 1.24 with gopls, delve, golangci-lint";
      };
      java-android = {
        description = "Java 17 + Android with Maven, Gradle, ktfmt";
      };
      lua = {
        description = "Lua with lua-language-server, stylua";
      };
      nix = {
        description = "Nix with alejandra, nil (common base packages)";
      };
      nodejs-20 = {
        description = "Node.js 20 with yarn, typescript-language-server, prettierd";
      };
      nodejs-22 = {
        description = "Node.js 22 with yarn, pnpm, typescript-language-server, prettierd";
      };
      python-311 = {
        description = "Python 3.11 with uv, ruff";
      };
      python-313 = {
        description = "Python 3.13 with uv, ruff";
      };
      python-314 = {
        description = "Python 3.14 with uv, ruff";
      };
      thrift = {
        description = "Apache Thrift with thrift-ls";
      };
      zig = {
        description = "Zig stable with zls";
      };
      zig-latest = {
        description = "Zig master (latest) with zls";
      };
    };
    template = {
      plain = {
        description = "Plain shell with common base packages";
      };
      rust = {
        description = "Rust project with fenix toolchain management";
      };
      go = {
        description = "Go project template";
      };
      lua = {
        description = "Lua project template";
      };
      zig = {
        description = "Zig project template";
      };
      nodejs = {
        description = "Node.js project template";
      };
      python = {
        description = "Python project template with uv";
      };
    };
    composite = {
      description = "Multi-shell composite (combine any shells via inputsFrom)";
    };
  };
}
