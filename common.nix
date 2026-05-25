{...}: {
  perSystem = {pkgs, ...}: {
    _module.args = {
      basePackages = with pkgs; [
        tree-sitter
        yaml-language-server
        marksman
        vscode-langservers-extracted
        alejandra
        nil
        just
      ];

      baseShellHook = ''
        echo "entering devshell"
      '';
    };
  };
}
