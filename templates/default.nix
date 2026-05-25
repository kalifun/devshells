{ ... }:
{
  flake.templates = {
    plain = {
      description = "Plain shell with common base packages";
      path = ./plain;
    };
    rust = {
      description = "Rust project with fenix toolchain management";
      path = ./rust;
    };
    go = {
      description = "Go project template";
      path = ./go;
    };
    lua = {
      description = "Lua project template";
      path = ./lua;
    };
    zig = {
      description = "Zig project template";
      path = ./zig;
    };
    nodejs = {
      description = "Node.js project template";
      path = ./nodejs;
    };
    python = {
      description = "Python project template with uv";
      path = ./python;
    };
  };
}
