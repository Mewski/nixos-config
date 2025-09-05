{ pkgs, ... }:

{
  # Use latest kernel packages
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Reduce console log verbosity
  boot.consoleLogLevel = 0;
}
