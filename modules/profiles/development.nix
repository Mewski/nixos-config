{ self, ... }:
{
  flake.nixosModules.development = {
    imports = [
      self.nixosModules.virtualization
      self.nixosModules.docker
    ];
  };

  flake.homeModules.development = {
    imports = [
      self.homeModules.binary-ninja
      self.homeModules.claude-code
      self.homeModules.direnv
      self.homeModules.gemini-cli
      self.homeModules.git
      self.homeModules.nixvim
      self.homeModules.zed-editor
    ];
  };
}
