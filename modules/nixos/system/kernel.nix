{ pkgs, ... }:

{
  # Use latest kernel packages
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Reduce console log verbosity during boot (0 = only emergency messages)
  boot.consoleLogLevel = 0;
}
