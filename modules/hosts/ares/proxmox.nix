{ inputs, ... }:
{
  flake.nixosModules.ares = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [
      inputs.proxmox-nixos.overlays.x86_64-linux
      (final: prev: let
        pve-qemu' = prev.pve-qemu.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ prev.fuse3 ];
          configureFlags = old.configureFlags ++ [ "--enable-fuse" ];
        });
      in {
        pve-qemu = pve-qemu';
        pve-qemu-server = prev.pve-qemu-server.override { pve-qemu = pve-qemu'; };
        pve-ha-manager = prev.pve-ha-manager.override { pve-qemu = pve-qemu'; pve-qemu-server = final.pve-qemu-server; };
        pve-manager = prev.pve-manager.override { pve-qemu = pve-qemu'; };
        pve-storage = prev.pve-storage.override { pve-qemu = pve-qemu'; };
        pve-edk2-firmware = prev.pve-edk2-firmware.override { pve-qemu = pve-qemu'; };
      })
    ];

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
