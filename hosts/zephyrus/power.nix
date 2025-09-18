{ ... }:

{
  # Enable system power management features
  powerManagement.enable = true;

  # Intel thermal management daemon for CPU temperature control
  services.thermald.enable = true;

  # TLP power management for laptop battery optimization
  services.tlp = {
    enable = true;
    settings = {
      # Stop charging at 80% and start again at 75% to maximize lifespan.
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # CPU energy performance policy configuration
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # CPU scaling governor selection
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      # CPU performance scaling limits
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MAX_PERF_ON_BAT = 60;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MIN_PERF_ON_BAT = 0;

      # PCIe Active State Power Management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";

      # SATA link power management
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";

      # WiFi power management configuration
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # Disable USB autosuspend to prevent device connectivity issues
      USB_AUTOSUSPEND = 0;
    };
  };
}
