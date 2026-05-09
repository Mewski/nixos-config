{ inputs, ... }:
{
  flake.homeModules.nixcord = {
    imports = [ inputs.nixcord.homeModules.nixcord ];

    programs.nixcord = {
      enable = true;
      discord.vencord.enable = true;
    };

    xdg.configFile."Discord-flags.conf".text = ''
      --enable-features=UseOzonePlatform,WaylandWindowDecorations,VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan
      --ozone-platform-hint=auto
      --disable-gpu-sandbox
    '';
  };
}
