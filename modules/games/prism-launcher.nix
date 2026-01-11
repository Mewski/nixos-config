{
  flake.homeModules.prism-launcher =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.prismlauncher.override {
          jdks = [ pkgs.graalvmPackages.graalvm-ce ];
        })
      ];
    };
}
