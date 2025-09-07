{
  description = "A collection of Nix flake templates";

  outputs = {self}: {
    templates = {
      plain = {
        description = "plain shell templatebased on base shell";
        path = ./templates/plain;
      };

      rust = {
        description = "rust shell templatebased on base shell";
        path = ./templates/rust;
      };

      go = {
        description = "go shell templatebased on base shell";
        path = ./templates/go;
      };

      lua = {
        description = "lua shell templatebased on base shell";
        path = ./templates/lua;
      };

      zig = {
        description = "zig shell templatebased on base shell";
        path = ./templates/zig;
      };
    };
  };
}
