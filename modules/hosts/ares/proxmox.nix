{ inputs, ... }:
{
  flake.nixosModules.ares = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

    boot.kernel.sysctl = {
      "net.bridge.bridge-nf-call-iptables" = 0;
      "net.bridge.bridge-nf-call-ip6tables" = 0;
    };

    networking.bridges = {
      vmbr0.interfaces = [ "ens1f0" ];
      vmbr1.interfaces = [ ];
      vmbr2.interfaces = [ ];
    };

    networking.firewall.allowedTCPPorts = [ 8006 ];

    environment.etc."ssl/openssl.cnf".text = ''
      openssl_conf = openssl_init

      [openssl_init]
      providers = provider_sect

      [provider_sect]
      default = default_sect

      [default_sect]
      activate = 1
    '';

    systemd.services.pveproxy.environment = {
      OPENSSL_CONF = "/etc/ssl/openssl.cnf";
    };

    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.0.50.10";
      bridges = [
        "vmbr0"
        "vmbr1"
        "vmbr2"
      ];
    };
  };
}
