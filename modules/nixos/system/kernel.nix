{ pkgs, ... }:

{
  # Use latest Linux kernel for newest hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Reduce boot console verbosity (0 = only emergency messages)
  boot.consoleLogLevel = 0;
}
