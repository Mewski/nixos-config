{ self, ... }:
{
  flake.nixosModules.security = {
    home-manager.sharedModules = [ self.homeModules.security ];
  };

  flake.homeModules.security =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.binary-ninja
      ];

      home.packages = with pkgs; [
        angr-management
        binwalk
        burpsuite
        gdb
        ghidra
        gobuster
        hashcat
        inetutils
        john
        lftp
        libseccomp
        lldb
        ltrace
        mariadb
        netexec
        nmap
        one_gadget
        proxychains-ng
        pwndbg
        pwndbg-lldb
        radare2
        redis
        rustscan
        sage
        seclists
        sleuthkit
        stegsolve
        strace
        valgrind
        volatility3
        vt-cli
        wabt
        wireshark-cli
        yara
      ];
    };
}
