{ ... }:

{
  # Enable system power management features
  powerManagement.enable = true;

  # Thermal management daemon for Intel CPUs
  services.thermald.enable = true;

  # TLP power management for laptops
  services.tlp = {
    enable = true;
    settings = {
      # CPU scaling governor selection
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # CPU energy performance policy
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # CPU performance scaling limits
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 25;

      # Disable USB autosuspend to prevent device issues
      USB_AUTOSUSPEND = 0;

      # SATA link power management
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";

      # WiFi power management
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # PCIe Active State Power Management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";
    };
  };
}
