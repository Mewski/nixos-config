{ inputs, self, ... }:
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    fileSystems."/etc/ssh".neededForBoot = true;

    sops = {
      defaultSopsFile = "${self}/secrets/astraeus/secrets.yaml";

      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };
}
