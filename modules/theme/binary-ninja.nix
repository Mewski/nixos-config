{ lib, ... }:
{
  flake.homeModules.theme =
    { scheme, ... }:
    {
      home.file.".binaryninja/themes/base16.bntheme".text = builtins.toJSON {
        name = "Base16";
        style = "Fusion";

        colors = {
          base00 = [
            (lib.toInt scheme.base00-rgb-r)
            (lib.toInt scheme.base00-rgb-g)
            (lib.toInt scheme.base00-rgb-b)
          ];
          base01 = [
            (lib.toInt scheme.base01-rgb-r)
            (lib.toInt scheme.base01-rgb-g)
            (lib.toInt scheme.base01-rgb-b)
          ];
          base02 = [
            (lib.toInt scheme.base02-rgb-r)
            (lib.toInt scheme.base02-rgb-g)
            (lib.toInt scheme.base02-rgb-b)
          ];
          base03 = [
            (lib.toInt scheme.base03-rgb-r)
            (lib.toInt scheme.base03-rgb-g)
            (lib.toInt scheme.base03-rgb-b)
          ];
          base04 = [
            (lib.toInt scheme.base04-rgb-r)
            (lib.toInt scheme.base04-rgb-g)
            (lib.toInt scheme.base04-rgb-b)
          ];
          base05 = [
            (lib.toInt scheme.base05-rgb-r)
            (lib.toInt scheme.base05-rgb-g)
            (lib.toInt scheme.base05-rgb-b)
          ];
          base06 = [
            (lib.toInt scheme.base06-rgb-r)
            (lib.toInt scheme.base06-rgb-g)
            (lib.toInt scheme.base06-rgb-b)
          ];
          base07 = [
            (lib.toInt scheme.base07-rgb-r)
            (lib.toInt scheme.base07-rgb-g)
            (lib.toInt scheme.base07-rgb-b)
          ];
          base08 = [
            (lib.toInt scheme.base08-rgb-r)
            (lib.toInt scheme.base08-rgb-g)
            (lib.toInt scheme.base08-rgb-b)
          ];
          base09 = [
            (lib.toInt scheme.base09-rgb-r)
            (lib.toInt scheme.base09-rgb-g)
            (lib.toInt scheme.base09-rgb-b)
          ];
          base0A = [
            (lib.toInt scheme.base0A-rgb-r)
            (lib.toInt scheme.base0A-rgb-g)
            (lib.toInt scheme.base0A-rgb-b)
          ];
          base0B = [
            (lib.toInt scheme.base0B-rgb-r)
            (lib.toInt scheme.base0B-rgb-g)
            (lib.toInt scheme.base0B-rgb-b)
          ];
          base0C = [
            (lib.toInt scheme.base0C-rgb-r)
            (lib.toInt scheme.base0C-rgb-g)
            (lib.toInt scheme.base0C-rgb-b)
          ];
          base0D = [
            (lib.toInt scheme.base0D-rgb-r)
            (lib.toInt scheme.base0D-rgb-g)
            (lib.toInt scheme.base0D-rgb-b)
          ];
          base0E = [
            (lib.toInt scheme.base0E-rgb-r)
            (lib.toInt scheme.base0E-rgb-g)
            (lib.toInt scheme.base0E-rgb-b)
          ];
          base0F = [
            (lib.toInt scheme.base0F-rgb-r)
            (lib.toInt scheme.base0F-rgb-g)
            (lib.toInt scheme.base0F-rgb-b)
          ];
        };

        palette = {
          Window = "base00";
          WindowText = "base05";
          Base = "base00";
          AlternateBase = "base04";
          ToolTipBase = "base01";
          ToolTipText = "base05";
          Text = "base05";
          Button = "base01";
          ButtonText = "base05";
          BrightText = "base0F";
          Link = "base0B";
          Highlight = "base01";
          HighlightedText = "base05";
          Light = "base03";
        };

        theme-colors = {
          addressColor = "base09";
          modifiedColor = "base08";
          insertedColor = "base0C";
          notPresentColor = "base03";
          selectionColor = "base02";
          outlineColor = "base05";

          backgroundHighlightDarkColor = "base00";
          backgroundHighlightLightColor = "base01";

          boldBackgroundHighlightDarkColor = "base0F";
          boldBackgroundHighlightLightColor = "base03";

          alphanumericHighlightColor = "base0A";
          printableHighlightColor = "base08";

          graphBackgroundDarkColor = "base01";
          graphBackgroundLightColor = "base01";
          graphNodeDarkColor = "base00";
          graphNodeLightColor = "base00";
          graphNodeOutlineColor = "base03";

          trueBranchColor = "base0B";
          falseBranchColor = "base08";
          unconditionalBranchColor = "base0D";
          altTrueBranchColor = "base06";
          altFalseBranchColor = "base07";
          altUnconditionalBranchColor = "base08";

          registerColor = "base0B";
          numberColor = "base09";

          codeSymbolColor = "base0D";
          dataSymbolColor = "base0B";

          stackVariableColor = "base08";
          importColor = "base0D";
          instructionHighlightColor = "base03";
          tokenHighlightColor = "base05";
          annotationColor = "base0E";
          opcodeColor = "base03";

          linearDisassemblyFunctionHeaderColor = "base00";
          linearDisassemblyBlockColor = "base00";
          linearDisassemblyNoteColor = "base01";
          linearDisassemblySeparatorColor = "base03";

          stringColor = "base0B";
          typeNameColor = "base0A";
          fieldNameColor = "base05";
          keywordColor = "base0E";
          uncertainColor = "base03";

          scriptConsoleOutputColor = "base0B";
          scriptConsoleErrorColor = "base08";
          scriptConsoleEchoColor = "base05";

          blueStandardHighlightColor = "base0D";
          greenStandardHighlightColor = "base0B";
          cyanStandardHighlightColor = "base0C";
          redStandardHighlightColor = "base08";
          magentaStandardHighlightColor = "base0E";
          yellowStandardHighlightColor = "base0A";
          orangeStandardHighlightColor = "base09";
          whiteStandardHighlightColor = "base04";
          blackStandardHighlightColor = "base02";
        };
      };
    };
}
