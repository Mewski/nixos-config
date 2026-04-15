{ self, ... }:
{
  flake.nixosModules.router =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.locale
        self.nixosModules.nix
      ];

      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };

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
