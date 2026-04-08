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
      auto-enum = pkgs.fetchFromGitHub {
        owner = "junron";
        repo = "auto-enum";
        rev = "ec12ba5b49c768ccbc3a226e69c6e2bed4d5101a";
        hash = "sha256-tqx7IHJMY7Jh8mu5wmeNrzmQE8IE97n/O8DW8c8zviE=";
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
      bdviewer = pkgs.fetchFromGitHub {
        owner = "PistonMiner";
        repo = "binaryninja-bindiff-viewer";
        rev = "b57d0ae4d42ed8654cb87e11c765f8339eb4aa67";
        hash = "sha256-FxLG7pFo4/VxaZcnctjtw4wjvjFkLn4V3MQc9iviwP4=";
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
        file.".binaryninja/plugins/auto-enum".source = "${auto-enum}/binjastub";
        file.".binaryninja/plugins/hashdb_bn".source = hashdb-bn;
        file.".binaryninja/plugins/copy-as-yara".source = copy-as-yara;
        file.".binaryninja/plugins/ioc_ninja".source = ioc-ninja;
        file.".binaryninja/plugins/x64dbgbinja".source = x64dbgbinja;
        file.".binaryninja/plugins/RopView".source = ropview;
        file.".binaryninja/plugins/bdviewer".source = bdviewer;
        file.".binaryninja/plugins/bnil-graph".source = bnil-graph;
        file.".binaryninja/plugins/ariadne".source = ariadne;

        sessionVariables.PYTHONPATH = "${pkgs.binary-ninja-personal-wayland}/opt/binaryninja/python";
      };
    };
}
