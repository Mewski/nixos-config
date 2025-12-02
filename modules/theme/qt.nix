{
  flake.nixosModules.theme =
    { pkgs, ... }:
    {
      qt = {
        enable = true;
        style = "kvantum";
        platformTheme = "qt5ct";
      };

      environment.systemPackages = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        kdePackages.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        kdePackages.qt6ct
        libsForQt5.qtwayland
        kdePackages.qtwayland
      ];
    };

  flake.homeModules.theme =
    {
      pkgs,
      scheme,
      fonts,
      polarity,
      ...
    }:
    let
      mustacheReplace =
        content:
        builtins.replaceStrings
          [
            "{{base00-hex}}"
            "{{base01-hex}}"
            "{{base02-hex}}"
            "{{base03-hex}}"
            "{{base04-hex}}"
            "{{base05-hex}}"
            "{{base06-hex}}"
            "{{base07-hex}}"
            "{{base08-hex}}"
            "{{base09-hex}}"
            "{{base0A-hex}}"
            "{{base0B-hex}}"
            "{{base0C-hex}}"
            "{{base0D-hex}}"
            "{{base0E-hex}}"
            "{{base0F-hex}}"
          ]
          [
            scheme.base00
            scheme.base01
            scheme.base02
            scheme.base03
            scheme.base04
            scheme.base05
            scheme.base06
            scheme.base07
            scheme.base08
            scheme.base09
            scheme.base0A
            scheme.base0B
            scheme.base0C
            scheme.base0D
            scheme.base0E
            scheme.base0F
          ]
          content;

      kvconfigContent = mustacheReplace (builtins.readFile ../../assets/kvconfig.mustache);

      svgContent = mustacheReplace (builtins.readFile ../../assets/kvantum.svg.mustache);

      kvantumPackage = pkgs.runCommandLocal "base16-kvantum" { } ''
        mkdir -p $out/share/Kvantum/Base16Kvantum
        cat > $out/share/Kvantum/Base16Kvantum/Base16Kvantum.kvconfig << 'EOF'
        ${kvconfigContent}
        EOF
        cat > $out/share/Kvantum/Base16Kvantum/Base16Kvantum.svg << 'EOF'
        ${svgContent}
        EOF
      '';

      iconTheme =
        if polarity == "dark" then
          {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          }
        else
          {
            name = "Papirus-Light";
            package = pkgs.papirus-icon-theme;
          };

      qtctConf = ''
        [Appearance]
        custom_palette=true
        style=kvantum
        icon_theme=${iconTheme.name}

        [Fonts]
        fixed="${fonts.monospace.name},${toString fonts.sizes.application}"
        general="${fonts.sansSerif.name},${toString fonts.sizes.application}"
      '';
    in
    {
      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
      };

      home.packages = [
        kvantumPackage
        iconTheme.package
      ];

      xdg.configFile = {
        "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
          General.theme = "Base16Kvantum";
        };
        "Kvantum/Base16Kvantum".source = "${kvantumPackage}/share/Kvantum/Base16Kvantum";
        "qt5ct/qt5ct.conf".text = qtctConf;
        "qt6ct/qt6ct.conf".text = qtctConf;
      };
    };
}
