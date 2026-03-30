{
  description = "A collection of Nix flake templates";

  outputs = {self}: {
    templates = {
      plain = {
        description = "plain shell template based on devshells";
        path = ./plain;
      };

      rust = {
        description = "rust shell template based on devshells";
        path = ./rust;
      };

      go = {
        description = "go shell template based on devshells";
        path = ./go;
      };

      lua = {
        description = "lua shell template based on devshells";
        path = ./lua;
      };

      zig = {
        description = "zig shell template based on devshells";
        path = ./zig;
      };

      nodejs = {
        description = "nodejs shell template based on devshells";
        path = ./nodejs;
      };

      python = {
        description = "python shell template based on devshells";
        path = ./python;
      };
    };
  };
}
