{
  flake.homeModules.binary-ninja =
    { pkgs, ... }:
    let
      binary-ninja-mcp-plugin = pkgs.fetchFromGitHub {
        owner = "fosdickio";
        repo = "binary_ninja_mcp";
        rev = "v1.1.0";
        hash = "sha256-uDAR/M1HrdduKztjp+dHbL9cx+bMzasdTQ0yQr1t/+w=";
      };
      snippets = pkgs.fetchFromGitHub {
        owner = "Vector35";
        repo = "snippets";
        rev = "1f528e946bed410bb287f14a66a12493d70c4085";
        hash = "sha256-4iJHAv1wcB7qaTxEGg8OIVzr1JQbEwbhdve/VS5zbnE=";
      };
      lighthouse = pkgs.fetchFromGitHub {
        owner = "gaasedelen";
        repo = "lighthouse";
        rev = "562595be9bd99e8a5dfef6017d608467f5706630";
        hash = "sha256-H2yVP4RlqBH65VlsAZBME3FTebEHbSfk/ZIj+qB3fLo=";
      };
      decomp2dbg = pkgs.fetchFromGitHub {
        owner = "mahaloz";
        repo = "decomp2dbg";
        rev = "d72d79cd05a4210aa95fc2634dd98e80adae3de2";
        hash = "sha256-Fg7qv83Ad/+g58XxPq5inbNELWr4MY7mJsPBLZ+U7PE=";
      };
      seninja = pkgs.fetchFromGitHub {
        owner = "borzacchiello";
        repo = "seninja";
        rev = "829a5b39ed81e4de0787470723a04962552ec245";
        hash = "sha256-cXMPg7kTT0btNVsNCNHi9qMLomYnYEkt04B6yryck10=";
      };
      vulnfanatic = pkgs.fetchFromGitHub {
        owner = "Martyx00";
        repo = "VulnFanatic";
        rev = "944cd6d8138bcebfa1f1fa8665f6bbb95914b8fd";
        hash = "sha256-qciQOFbAohWdkgc9RCSefG2RlT+w2ndOvk0+p7LP/hU=";
      };
      auto-enum = pkgs.fetchFromGitHub {
        owner = "junron";
        repo = "auto-enum";
        rev = "ec12ba5b49c768ccbc3a226e69c6e2bed4d5101a";
        hash = "sha256-tqx7IHJMY7Jh8mu5wmeNrzmQE8IE97n/O8DW8c8zviE=";
      };
      obfuscation-detection = pkgs.fetchFromGitHub {
        owner = "mrphrazer";
        repo = "obfuscation_detection";
        rev = "ce459c864a16bf4b36270c12ae7f985055db6df8";
        hash = "sha256-dRPGzBpPe4tWkpJ8GdnCYqA7/k0apcg/Bysu6/2TXZE=";
      };
      hashdb-bn = pkgs.fetchFromGitHub {
        owner = "cxiao";
        repo = "hashdb_bn";
        rev = "eb0ab0585135a6812cce7d793d54fdf05f19dd49";
        hash = "sha256-lfrHRgPTepl0P98GsLKqY30i5ElSH/PDEm6faVeFrEc=";
      };
      copy-as-yara = pkgs.fetchFromGitHub {
        owner = "ald3ns";
        repo = "copy-as-yara";
        rev = "539b28a9ab1b687e70eaa62c7280c8a1c3a59c66";
        hash = "sha256-o43Zy5qnE5aYJT3qoy364QYwFHxfwmdsiH2+9VMlNqI=";
      };
      ioc-ninja = pkgs.fetchFromGitHub {
        owner = "CX330Blake";
        repo = "ioc_ninja";
        rev = "9e83fa4fc5202330d3b4d7bd7095c6a5a5481d56";
        hash = "sha256-OG69NghGog8tGEp6K46JYB7P3hXvH/6U9WPhjWShrZI=";
      };
      cryptoscan = pkgs.fetchFromGitHub {
        owner = "Rami114";
        repo = "cryptoscan";
        rev = "403f9762c368ef19d25252d16fe3eb5696228aa3";
        hash = "sha256-ODQY5Vc/+qiM7R/3GcwuzbzVt9RxmbAsyPIV4SO1KSQ=";
      };
      themida-unmutate-bn = pkgs.fetchFromGitHub {
        owner = "ergrelet";
        repo = "themida-unmutate-bn";
        rev = "c9c4da980d978037ecdb4a64f75ee1222d0517ce";
        hash = "sha256-d4eE/NI7v7zM+3beYNJuR+YTX9AzSXzvvw0KoZgA/Mw=";
      };
      x64dbgbinja = pkgs.fetchFromGitHub {
        owner = "x64dbg";
        repo = "x64dbgbinja";
        rev = "3fea2d23d0db146909e6a547a208d82338f7e115";
        hash = "sha256-LfPY+HgPzBWUnn4SxCVZBTmfRitfqHpzImVarUyOZqI=";
      };
      ropview = pkgs.fetchFromGitHub {
        owner = "elbee-cyber";
        repo = "RopView";
        rev = "bb9cd8fe06569dc2f56e281979dd009bfef78b8d";
        hash = "sha256-5frRkvy3AC4RgutknJZ0ZEm6wKAQCQmAm2YyNBFA3oI=";
      };
      bnil-graph = pkgs.fetchFromGitHub {
        owner = "withzombies";
        repo = "bnil-graph";
        rev = "30d2986dcd0f14308f1c080cb5deb780951ba57d";
        hash = "sha256-/r3uj3VKb370cqKnr8bZjOaXEIXpSwr9SH6QWk8MPm8=";
      };
      ariadne = pkgs.fetchFromGitHub {
        owner = "seeinglogic";
        repo = "ariadne";
        rev = "75726a2f690316467cbbc58183ce2e43d6c05012";
        hash = "sha256-+uU2DVxwDprYr2U4O3xIBWgyAxntFH/uaVje7VG216M=";
      };
    in
    {
      home = {
        packages = [ pkgs.binary-ninja-personal-wayland ];

        file.".binaryninja/settings.json".text = builtins.toJSON {
          "ui.theme.name" = "Ninja Dark";
          "network.enableUpdates" = false;
          "network.enableReleaseNotes" = false;
        };

        file.".binaryninja/plugins/binary_ninja_mcp".source = binary-ninja-mcp-plugin;
        file.".binaryninja/plugins/snippets".source = snippets;
        file.".binaryninja/plugins/lighthouse".source = "${lighthouse}/plugins/lighthouse";
        file.".binaryninja/plugins/decomp2dbg".source = "${decomp2dbg}/decompilers/d2d_binja";
        file.".binaryninja/plugins/seninja".source = seninja;
        file.".binaryninja/plugins/VulnFanatic".source = vulnfanatic;
        file.".binaryninja/plugins/auto-enum".source = "${auto-enum}/binjastub";
        file.".binaryninja/plugins/obfuscation_detection".source = obfuscation-detection;
        file.".binaryninja/plugins/hashdb_bn".source = hashdb-bn;
        file.".binaryninja/plugins/copy-as-yara".source = copy-as-yara;
        file.".binaryninja/plugins/ioc_ninja".source = ioc-ninja;
        file.".binaryninja/plugins/cryptoscan".source = cryptoscan;
        file.".binaryninja/plugins/themida-unmutate-bn".source = themida-unmutate-bn;
        file.".binaryninja/plugins/x64dbgbinja".source = x64dbgbinja;
        file.".binaryninja/plugins/RopView".source = ropview;
        file.".binaryninja/plugins/bnil-graph".source = bnil-graph;
        file.".binaryninja/plugins/ariadne".source = ariadne;

        sessionVariables.PYTHONPATH = "${pkgs.binary-ninja-personal-wayland}/opt/binaryninja/python";
      };
    };
}
