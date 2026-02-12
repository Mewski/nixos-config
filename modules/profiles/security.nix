{ self, ... }:
{
  flake.nixosModules.security = {
    home-manager.sharedModules = [ self.homeModules.security ];
  };

  flake.homeModules.security =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.binary-ninja
      ];

      home.packages = with pkgs; [
        burpsuite
        gdb
        lldb
        proxychains-ng
        radare2
        seclists
        vt-cli
      ];
    };
}
