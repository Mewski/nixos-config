{
  flake.homeModules.zephyrus = {
    programs.fish.functions.vpn = ''
      if test (count $argv) -ne 2
        echo "Usage: vpn <up|down> <name>"
        return 1
      end

      set action $argv[1]
      set name $argv[2]

      switch $action
        case up
          sudo systemctl start "wg-quick-$name"
        case down
          sudo systemctl stop "wg-quick-$name"
        case '*'
          echo "Unknown action: $action (use up or down)"
          return 1
      end
    '';
  };
}
