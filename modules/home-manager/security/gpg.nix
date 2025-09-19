{ ... }:

{
  # GnuPG configuration with agent support
  programs.gpg = {
    enable = true;
  };

  # GPG agent configuration for SSH signing
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = null; # Use system default pinentry
  };
}
