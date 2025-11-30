{
  flake.homeModules.claude-code = {
    programs.claude-code.enable = true;

    persist.directories = [
      ".claude"
    ];
  };
}
