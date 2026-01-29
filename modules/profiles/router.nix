{ self, ... }:
{
  flake.nixosModules.router =
    { lib, pkgs, ... }:
    {
      imports = [ self.nixosModules.nix ];

      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };

      time.timeZone = lib.mkDefault "America/Chicago";

      i18n.defaultLocale = "en_US.UTF-8";

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      environment.systemPackages = with pkgs; [
        bird3
        btop
        git
        vim
      ];
    };
}
