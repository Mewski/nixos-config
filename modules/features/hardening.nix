{
  flake.nixosModules.hardening = {
    boot = {
      kernelParams = [
        "init_on_alloc=1"
        "init_on_free=1"
        "page_alloc.shuffle=1"
        "randomize_kstack_offset=on"
        "slab_nomerge"
        "vsyscall=none"
      ];

      kernel.sysctl = {
        "kernel.kexec_load_disabled" = 1;
        "kernel.sysrq" = 0;
      };
    };

    security.apparmor.enable = true;
  };
}
