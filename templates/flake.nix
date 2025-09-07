{
  description = "A collection of Nix flake templates";

  outputs = {self}: {
    templates = {
      plain = {
        description = "plain shell template based on base shell";
        path = ./plain;
      };

      rust = {
        description = "rust shell template based on base shell";
        path = ./rust;
      };

      go = {
        description = "go shell template based on base shell";
        path = ./go;
      };

      lua = {
        description = "lua shell template based on base shell";
        path = ./lua;
      };

      zig = {
        description = "zig shell template based on base shell";
        path = ./zig;
      };

      nodejs = {
        description = "nodejs shell template based on base shell";
        path = ./nodejs;
      };

      python = {
        description = "python shell template based on base shell";
        path = ./python;
      };
    };
  };
}
