{ inputs, ... }:
{
  flake.homeModules.nixcord = {
    imports = [ inputs.nixcord.homeModules.nixcord ];

    programs.nixcord = {
      enable = true;

      vesktop = {
        enable = true;
        settings = {
          discordBranch = "stable";
          arRPC = true;
          hardwareAcceleration = true;
          hardwareVideoAcceleration = true;
          tray = true;
          minimizeToTray = true;
          staticTitle = true;
          disableMinSize = true;
          audio = {
            deviceSelect = true;
            granularSelect = true;
            ignoreVirtual = true;
          };
        };
      };

      config = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = true;
        disableMinSize = true;
        plugins = {
          anonymiseFileNames.enable = true;
          betterSettings.enable = true;
          callTimer.enable = true;
          ClearURLs.enable = true;
          consoleJanitor.enable = true;
          copyFileContents.enable = true;
          CopyUserURLs.enable = true;
          crashHandler.enable = true;
          fixImagesQuality.enable = true;
          webKeybinds.enable = true;
        };
      };

      extraConfig.notifications = {
        timeout = 5000;
        position = "bottom-right";
        useNative = "not-focused";
        logLimit = 50;
      };
    };
  };
}
