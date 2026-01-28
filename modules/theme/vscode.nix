{
  flake.homeModules.vscode =
    { theme, scheme, ... }:
    {
      programs.vscode = {
        enable = true;

        profiles.default.userSettings = {
          "editor.fontFamily" = "'${theme.fonts.monospace.name}', monospace";
          "editor.fontSize" = theme.fonts.sizes.terminal * 4.0 / 3.0;
          "editor.fontLigatures" = true;
          "terminal.integrated.fontFamily" = "'${theme.fonts.monospace.name}'";
          "terminal.integrated.fontSize" = theme.fonts.sizes.terminal * 4.0 / 3.0;

          "workbench.colorTheme" = "Default Dark Modern";
          "workbench.iconTheme" = "material-icon-theme";

          "workbench.colorCustomizations" = {
            "foreground" = scheme.withHashtag.base05;
            "focusBorder" = scheme.withHashtag.base0D;
            "selection.background" = "${scheme.withHashtag.base02}80";
            "widget.shadow" = "${scheme.withHashtag.base00}80";
            "descriptionForeground" = scheme.withHashtag.base04;
            "errorForeground" = scheme.withHashtag.base08;
            "icon.foreground" = scheme.withHashtag.base05;
            "sash.hoverBorder" = scheme.withHashtag.base0D;

            "window.activeBorder" = scheme.withHashtag.base01;
            "window.inactiveBorder" = scheme.withHashtag.base01;

            "textBlockQuote.background" = scheme.withHashtag.base01;
            "textBlockQuote.border" = scheme.withHashtag.base03;
            "textCodeBlock.background" = scheme.withHashtag.base01;
            "textLink.activeForeground" = scheme.withHashtag.base0D;
            "textLink.foreground" = scheme.withHashtag.base0D;
            "textPreformat.foreground" = scheme.withHashtag.base05;
            "textSeparator.foreground" = scheme.withHashtag.base03;

            "toolbar.hoverBackground" = scheme.withHashtag.base02;
            "toolbar.activeBackground" = scheme.withHashtag.base02;

            "button.background" = scheme.withHashtag.base0D;
            "button.foreground" = scheme.withHashtag.base00;
            "button.hoverBackground" = scheme.withHashtag.base16;
            "button.secondaryBackground" = scheme.withHashtag.base02;
            "button.secondaryForeground" = scheme.withHashtag.base05;
            "button.secondaryHoverBackground" = scheme.withHashtag.base03;
            "checkbox.background" = scheme.withHashtag.base01;
            "checkbox.foreground" = scheme.withHashtag.base05;
            "checkbox.border" = scheme.withHashtag.base03;

            "dropdown.background" = scheme.withHashtag.base01;
            "dropdown.foreground" = scheme.withHashtag.base05;
            "dropdown.border" = scheme.withHashtag.base03;
            "dropdown.listBackground" = scheme.withHashtag.base01;

            "input.background" = scheme.withHashtag.base01;
            "input.foreground" = scheme.withHashtag.base05;
            "input.border" = scheme.withHashtag.base03;
            "input.placeholderForeground" = scheme.withHashtag.base03;
            "inputOption.activeBackground" = "${scheme.withHashtag.base0D}40";
            "inputOption.activeBorder" = scheme.withHashtag.base0D;
            "inputOption.activeForeground" = scheme.withHashtag.base05;
            "inputOption.hoverBackground" = scheme.withHashtag.base02;
            "inputValidation.errorBackground" = scheme.withHashtag.base01;
            "inputValidation.errorBorder" = scheme.withHashtag.base08;
            "inputValidation.errorForeground" = scheme.withHashtag.base08;
            "inputValidation.infoBackground" = scheme.withHashtag.base01;
            "inputValidation.infoBorder" = scheme.withHashtag.base0D;
            "inputValidation.infoForeground" = scheme.withHashtag.base0D;
            "inputValidation.warningBackground" = scheme.withHashtag.base01;
            "inputValidation.warningBorder" = scheme.withHashtag.base0A;
            "inputValidation.warningForeground" = scheme.withHashtag.base0A;

            "scrollbar.shadow" = "${scheme.withHashtag.base00}80";
            "scrollbarSlider.background" = "${scheme.withHashtag.base02}80";
            "scrollbarSlider.hoverBackground" = "${scheme.withHashtag.base03}80";
            "scrollbarSlider.activeBackground" = scheme.withHashtag.base03;

            "badge.background" = scheme.withHashtag.base0D;
            "badge.foreground" = scheme.withHashtag.base00;

            "progressBar.background" = scheme.withHashtag.base0D;

            "list.activeSelectionBackground" = scheme.withHashtag.base02;
            "list.activeSelectionForeground" = scheme.withHashtag.base05;
            "list.activeSelectionIconForeground" = scheme.withHashtag.base05;
            "list.dropBackground" = "${scheme.withHashtag.base02}80";
            "list.focusBackground" = scheme.withHashtag.base02;
            "list.focusForeground" = scheme.withHashtag.base05;
            "list.focusHighlightForeground" = scheme.withHashtag.base0D;
            "list.focusOutline" = scheme.withHashtag.base02;
            "list.highlightForeground" = scheme.withHashtag.base0D;
            "list.hoverBackground" = scheme.withHashtag.base01;
            "list.hoverForeground" = scheme.withHashtag.base05;
            "list.inactiveSelectionBackground" = scheme.withHashtag.base01;
            "list.inactiveSelectionForeground" = scheme.withHashtag.base05;
            "list.inactiveSelectionIconForeground" = scheme.withHashtag.base05;
            "list.inactiveFocusBackground" = scheme.withHashtag.base01;
            "list.inactiveFocusOutline" = scheme.withHashtag.base01;
            "list.invalidItemForeground" = scheme.withHashtag.base08;
            "list.errorForeground" = scheme.withHashtag.base08;
            "list.warningForeground" = scheme.withHashtag.base0A;
            "listFilterWidget.background" = scheme.withHashtag.base01;
            "listFilterWidget.outline" = scheme.withHashtag.base03;
            "listFilterWidget.noMatchesOutline" = scheme.withHashtag.base08;
            "list.filterMatchBackground" = "${scheme.withHashtag.base0D}40";
            "list.filterMatchBorder" = scheme.withHashtag.base0D;
            "list.deemphasizedForeground" = scheme.withHashtag.base03;
            "tree.indentGuidesStroke" = scheme.withHashtag.base02;
            "tree.tableColumnsBorder" = scheme.withHashtag.base02;
            "tree.tableOddRowsBackground" = scheme.withHashtag.base01;

            "activityBar.background" = scheme.withHashtag.base00;
            "activityBar.foreground" = scheme.withHashtag.base05;
            "activityBar.inactiveForeground" = scheme.withHashtag.base03;
            "activityBar.border" = scheme.withHashtag.base01;
            "activityBar.activeBorder" = scheme.withHashtag.base0D;
            "activityBar.activeBackground" = scheme.withHashtag.base01;
            "activityBar.dropBorder" = scheme.withHashtag.base0D;
            "activityBarBadge.background" = scheme.withHashtag.base0D;
            "activityBarBadge.foreground" = scheme.withHashtag.base00;

            "sideBar.background" = scheme.withHashtag.base00;
            "sideBar.foreground" = scheme.withHashtag.base05;
            "sideBar.border" = scheme.withHashtag.base01;
            "sideBar.dropBackground" = "${scheme.withHashtag.base02}80";
            "sideBarTitle.foreground" = scheme.withHashtag.base05;
            "sideBarSectionHeader.background" = scheme.withHashtag.base01;
            "sideBarSectionHeader.foreground" = scheme.withHashtag.base05;
            "sideBarSectionHeader.border" = scheme.withHashtag.base01;

            "minimap.background" = scheme.withHashtag.base00;
            "minimap.findMatchHighlight" = "${scheme.withHashtag.base0D}80";
            "minimap.selectionHighlight" = "${scheme.withHashtag.base02}80";
            "minimap.errorHighlight" = scheme.withHashtag.base08;
            "minimap.warningHighlight" = scheme.withHashtag.base0A;
            "minimap.selectionOccurrenceHighlight" = "${scheme.withHashtag.base02}80";
            "minimapSlider.background" = "${scheme.withHashtag.base02}40";
            "minimapSlider.hoverBackground" = "${scheme.withHashtag.base02}60";
            "minimapSlider.activeBackground" = "${scheme.withHashtag.base02}80";
            "minimapGutter.addedBackground" = scheme.withHashtag.base0B;
            "minimapGutter.modifiedBackground" = scheme.withHashtag.base0A;
            "minimapGutter.deletedBackground" = scheme.withHashtag.base08;

            "editorGroup.border" = scheme.withHashtag.base01;
            "editorGroup.dropBackground" = "${scheme.withHashtag.base02}80";
            "editorGroup.emptyBackground" = scheme.withHashtag.base00;
            "editorGroup.focusedEmptyBorder" = scheme.withHashtag.base01;
            "editorGroupHeader.noTabsBackground" = scheme.withHashtag.base00;
            "editorGroupHeader.tabsBackground" = scheme.withHashtag.base00;
            "editorGroupHeader.tabsBorder" = scheme.withHashtag.base01;
            "editorGroupHeader.border" = scheme.withHashtag.base01;

            "tab.activeBackground" = scheme.withHashtag.base01;
            "tab.activeForeground" = scheme.withHashtag.base05;
            "tab.activeBorder" = scheme.withHashtag.base01;
            "tab.activeBorderTop" = scheme.withHashtag.base0D;
            "tab.activeModifiedBorder" = scheme.withHashtag.base0A;
            "tab.border" = scheme.withHashtag.base00;
            "tab.hoverBackground" = scheme.withHashtag.base01;
            "tab.hoverForeground" = scheme.withHashtag.base05;
            "tab.hoverBorder" = scheme.withHashtag.base01;
            "tab.inactiveBackground" = scheme.withHashtag.base00;
            "tab.inactiveForeground" = scheme.withHashtag.base03;
            "tab.inactiveModifiedBorder" = "${scheme.withHashtag.base0A}80";
            "tab.lastPinnedBorder" = scheme.withHashtag.base02;
            "tab.unfocusedActiveBackground" = scheme.withHashtag.base01;
            "tab.unfocusedActiveForeground" = scheme.withHashtag.base04;
            "tab.unfocusedActiveBorder" = scheme.withHashtag.base01;
            "tab.unfocusedActiveBorderTop" = "${scheme.withHashtag.base0D}80";
            "tab.unfocusedActiveModifiedBorder" = "${scheme.withHashtag.base0A}80";
            "tab.unfocusedHoverBackground" = scheme.withHashtag.base01;
            "tab.unfocusedHoverForeground" = scheme.withHashtag.base05;
            "tab.unfocusedHoverBorder" = scheme.withHashtag.base01;
            "tab.unfocusedInactiveBackground" = scheme.withHashtag.base00;
            "tab.unfocusedInactiveForeground" = scheme.withHashtag.base03;
            "tab.unfocusedInactiveModifiedBorder" = "${scheme.withHashtag.base0A}40";

            "editor.background" = scheme.withHashtag.base00;
            "editor.foreground" = scheme.withHashtag.base05;
            "editorLineNumber.foreground" = scheme.withHashtag.base03;
            "editorLineNumber.activeForeground" = scheme.withHashtag.base05;
            "editorCursor.background" = scheme.withHashtag.base00;
            "editorCursor.foreground" = scheme.withHashtag.base05;
            "editor.selectionBackground" = "${scheme.withHashtag.base02}80";
            "editor.selectionForeground" = scheme.withHashtag.base05;
            "editor.inactiveSelectionBackground" = "${scheme.withHashtag.base02}40";
            "editor.selectionHighlightBackground" = "${scheme.withHashtag.base02}60";
            "editor.selectionHighlightBorder" = "${scheme.withHashtag.base03}00";
            "editor.wordHighlightBackground" = "${scheme.withHashtag.base02}80";
            "editor.wordHighlightBorder" = "${scheme.withHashtag.base03}00";
            "editor.wordHighlightStrongBackground" = "${scheme.withHashtag.base03}80";
            "editor.wordHighlightStrongBorder" = "${scheme.withHashtag.base03}00";
            "editor.findMatchBackground" = "${scheme.withHashtag.base09}80";
            "editor.findMatchHighlightBackground" = "${scheme.withHashtag.base09}40";
            "editor.findRangeHighlightBackground" = "${scheme.withHashtag.base02}40";
            "editor.findMatchBorder" = scheme.withHashtag.base09;
            "editor.findMatchHighlightBorder" = "${scheme.withHashtag.base09}00";
            "editor.findRangeHighlightBorder" = "${scheme.withHashtag.base02}00";
            "editor.hoverHighlightBackground" = "${scheme.withHashtag.base02}40";
            "editor.lineHighlightBackground" = scheme.withHashtag.base01;
            "editor.lineHighlightBorder" = "${scheme.withHashtag.base01}00";
            "editorLink.activeForeground" = scheme.withHashtag.base0D;
            "editor.rangeHighlightBackground" = "${scheme.withHashtag.base02}40";
            "editor.rangeHighlightBorder" = "${scheme.withHashtag.base02}00";
            "editor.symbolHighlightBackground" = "${scheme.withHashtag.base0D}40";
            "editor.symbolHighlightBorder" = "${scheme.withHashtag.base0D}00";
            "editorWhitespace.foreground" = scheme.withHashtag.base02;
            "editorIndentGuide.background1" = scheme.withHashtag.base02;
            "editorIndentGuide.activeBackground1" = scheme.withHashtag.base03;
            "editorInlayHint.background" = "${scheme.withHashtag.base02}80";
            "editorInlayHint.foreground" = scheme.withHashtag.base04;
            "editorInlayHint.typeForeground" = scheme.withHashtag.base04;
            "editorInlayHint.typeBackground" = "${scheme.withHashtag.base02}80";
            "editorInlayHint.parameterForeground" = scheme.withHashtag.base04;
            "editorInlayHint.parameterBackground" = "${scheme.withHashtag.base02}80";
            "editorRuler.foreground" = scheme.withHashtag.base02;
            "editor.linkedEditingBackground" = "${scheme.withHashtag.base02}80";
            "editorCodeLens.foreground" = scheme.withHashtag.base03;
            "editorLightBulb.foreground" = scheme.withHashtag.base0A;
            "editorLightBulbAutoFix.foreground" = scheme.withHashtag.base0D;

            "editorBracketMatch.background" = "${scheme.withHashtag.base02}80";
            "editorBracketMatch.border" = scheme.withHashtag.base03;
            "editorBracketHighlight.unexpectedBracket.foreground" = scheme.withHashtag.base08;

            "editorOverviewRuler.border" = scheme.withHashtag.base01;
            "editorOverviewRuler.background" = scheme.withHashtag.base00;
            "editorOverviewRuler.findMatchForeground" = "${scheme.withHashtag.base0D}80";
            "editorOverviewRuler.rangeHighlightForeground" = "${scheme.withHashtag.base02}80";
            "editorOverviewRuler.selectionHighlightForeground" = "${scheme.withHashtag.base02}80";
            "editorOverviewRuler.wordHighlightForeground" = "${scheme.withHashtag.base02}80";
            "editorOverviewRuler.wordHighlightStrongForeground" = "${scheme.withHashtag.base03}80";
            "editorOverviewRuler.modifiedForeground" = scheme.withHashtag.base0A;
            "editorOverviewRuler.addedForeground" = scheme.withHashtag.base0B;
            "editorOverviewRuler.deletedForeground" = scheme.withHashtag.base08;
            "editorOverviewRuler.errorForeground" = scheme.withHashtag.base08;
            "editorOverviewRuler.warningForeground" = scheme.withHashtag.base0A;
            "editorOverviewRuler.infoForeground" = scheme.withHashtag.base0D;
            "editorOverviewRuler.bracketMatchForeground" = scheme.withHashtag.base03;

            "editorError.foreground" = scheme.withHashtag.base08;
            "editorError.background" = "${scheme.withHashtag.base08}00";
            "editorError.border" = "${scheme.withHashtag.base08}00";
            "editorWarning.foreground" = scheme.withHashtag.base0A;
            "editorWarning.background" = "${scheme.withHashtag.base0A}00";
            "editorWarning.border" = "${scheme.withHashtag.base0A}00";
            "editorInfo.foreground" = scheme.withHashtag.base0D;
            "editorInfo.background" = "${scheme.withHashtag.base0D}00";
            "editorInfo.border" = "${scheme.withHashtag.base0D}00";
            "editorHint.foreground" = scheme.withHashtag.base0C;
            "editorHint.border" = "${scheme.withHashtag.base0C}00";
            "problemsErrorIcon.foreground" = scheme.withHashtag.base08;
            "problemsWarningIcon.foreground" = scheme.withHashtag.base0A;
            "problemsInfoIcon.foreground" = scheme.withHashtag.base0D;

            "editorUnnecessaryCode.border" = "${scheme.withHashtag.base03}00";
            "editorUnnecessaryCode.opacity" = "#000000aa";

            "editorGutter.background" = scheme.withHashtag.base00;
            "editorGutter.modifiedBackground" = scheme.withHashtag.base0A;
            "editorGutter.addedBackground" = scheme.withHashtag.base0B;
            "editorGutter.deletedBackground" = scheme.withHashtag.base08;
            "editorGutter.commentRangeForeground" = scheme.withHashtag.base03;
            "editorGutter.foldingControlForeground" = scheme.withHashtag.base03;

            "diffEditor.insertedTextBackground" = "${scheme.withHashtag.base0B}20";
            "diffEditor.insertedTextBorder" = "${scheme.withHashtag.base0B}00";
            "diffEditor.removedTextBackground" = "${scheme.withHashtag.base08}20";
            "diffEditor.removedTextBorder" = "${scheme.withHashtag.base08}00";
            "diffEditor.border" = scheme.withHashtag.base01;
            "diffEditor.diagonalFill" = scheme.withHashtag.base02;
            "diffEditor.insertedLineBackground" = "${scheme.withHashtag.base0B}20";
            "diffEditor.removedLineBackground" = "${scheme.withHashtag.base08}20";
            "diffEditorGutter.insertedLineBackground" = "${scheme.withHashtag.base0B}40";
            "diffEditorGutter.removedLineBackground" = "${scheme.withHashtag.base08}40";
            "diffEditorOverview.insertedForeground" = scheme.withHashtag.base0B;
            "diffEditorOverview.removedForeground" = scheme.withHashtag.base08;

            "editorWidget.background" = scheme.withHashtag.base01;
            "editorWidget.foreground" = scheme.withHashtag.base05;
            "editorWidget.border" = scheme.withHashtag.base02;
            "editorWidget.resizeBorder" = scheme.withHashtag.base0D;
            "editorSuggestWidget.background" = scheme.withHashtag.base01;
            "editorSuggestWidget.border" = scheme.withHashtag.base02;
            "editorSuggestWidget.foreground" = scheme.withHashtag.base05;
            "editorSuggestWidget.focusHighlightForeground" = scheme.withHashtag.base0D;
            "editorSuggestWidget.highlightForeground" = scheme.withHashtag.base0D;
            "editorSuggestWidget.selectedBackground" = scheme.withHashtag.base02;
            "editorSuggestWidget.selectedForeground" = scheme.withHashtag.base05;
            "editorSuggestWidget.selectedIconForeground" = scheme.withHashtag.base05;
            "editorSuggestWidgetStatus.foreground" = scheme.withHashtag.base03;
            "editorHoverWidget.background" = scheme.withHashtag.base01;
            "editorHoverWidget.foreground" = scheme.withHashtag.base05;
            "editorHoverWidget.border" = scheme.withHashtag.base02;
            "editorHoverWidget.highlightForeground" = scheme.withHashtag.base0D;
            "editorHoverWidget.statusBarBackground" = scheme.withHashtag.base02;
            "editorGhostText.background" = "${scheme.withHashtag.base02}00";
            "editorGhostText.foreground" = scheme.withHashtag.base03;
            "editorGhostText.border" = "${scheme.withHashtag.base03}00";
            "editorStickyScroll.background" = scheme.withHashtag.base00;
            "editorStickyScrollHover.background" = scheme.withHashtag.base01;

            "debugExceptionWidget.background" = scheme.withHashtag.base01;
            "debugExceptionWidget.border" = scheme.withHashtag.base08;

            "editorMarkerNavigation.background" = scheme.withHashtag.base01;
            "editorMarkerNavigationError.background" = scheme.withHashtag.base08;
            "editorMarkerNavigationWarning.background" = scheme.withHashtag.base0A;
            "editorMarkerNavigationInfo.background" = scheme.withHashtag.base0D;
            "editorMarkerNavigationError.headerBackground" = "${scheme.withHashtag.base08}40";
            "editorMarkerNavigationWarning.headerBackground" = "${scheme.withHashtag.base0A}40";
            "editorMarkerNavigationInfo.headerBackground" = "${scheme.withHashtag.base0D}40";

            "peekView.border" = scheme.withHashtag.base0D;
            "peekViewEditor.background" = scheme.withHashtag.base01;
            "peekViewEditorGutter.background" = scheme.withHashtag.base01;
            "peekViewEditor.matchHighlightBackground" = "${scheme.withHashtag.base09}40";
            "peekViewEditor.matchHighlightBorder" = "${scheme.withHashtag.base09}00";
            "peekViewResult.background" = scheme.withHashtag.base00;
            "peekViewResult.fileForeground" = scheme.withHashtag.base05;
            "peekViewResult.lineForeground" = scheme.withHashtag.base04;
            "peekViewResult.matchHighlightBackground" = "${scheme.withHashtag.base09}40";
            "peekViewResult.selectionBackground" = scheme.withHashtag.base02;
            "peekViewResult.selectionForeground" = scheme.withHashtag.base05;
            "peekViewTitle.background" = scheme.withHashtag.base01;
            "peekViewTitleDescription.foreground" = scheme.withHashtag.base04;
            "peekViewTitleLabel.foreground" = scheme.withHashtag.base05;

            "merge.currentHeaderBackground" = "${scheme.withHashtag.base0B}40";
            "merge.currentContentBackground" = "${scheme.withHashtag.base0B}20";
            "merge.incomingHeaderBackground" = "${scheme.withHashtag.base0D}40";
            "merge.incomingContentBackground" = "${scheme.withHashtag.base0D}20";
            "merge.border" = scheme.withHashtag.base02;
            "merge.commonHeaderBackground" = "${scheme.withHashtag.base03}40";
            "merge.commonContentBackground" = "${scheme.withHashtag.base03}20";
            "editorOverviewRuler.currentContentForeground" = scheme.withHashtag.base0B;
            "editorOverviewRuler.incomingContentForeground" = scheme.withHashtag.base0D;
            "editorOverviewRuler.commonContentForeground" = scheme.withHashtag.base03;
            "mergeEditor.change.background" = "${scheme.withHashtag.base0D}20";
            "mergeEditor.change.word.background" = "${scheme.withHashtag.base0D}40";
            "mergeEditor.conflict.unhandledUnfocused.border" = "${scheme.withHashtag.base09}80";
            "mergeEditor.conflict.unhandledFocused.border" = scheme.withHashtag.base09;
            "mergeEditor.conflict.handledUnfocused.border" = "${scheme.withHashtag.base0B}80";
            "mergeEditor.conflict.handledFocused.border" = scheme.withHashtag.base0B;
            "mergeEditor.conflict.handled.minimapOverViewRuler" = scheme.withHashtag.base0B;
            "mergeEditor.conflict.unhandled.minimapOverViewRuler" = scheme.withHashtag.base09;

            "panel.background" = scheme.withHashtag.base00;
            "panel.border" = scheme.withHashtag.base01;
            "panel.dropBorder" = scheme.withHashtag.base0D;
            "panelTitle.activeBorder" = scheme.withHashtag.base0D;
            "panelTitle.activeForeground" = scheme.withHashtag.base05;
            "panelTitle.inactiveForeground" = scheme.withHashtag.base03;
            "panelInput.border" = scheme.withHashtag.base02;
            "panelSection.border" = scheme.withHashtag.base01;
            "panelSection.dropBackground" = "${scheme.withHashtag.base02}80";
            "panelSectionHeader.background" = scheme.withHashtag.base01;
            "panelSectionHeader.foreground" = scheme.withHashtag.base05;
            "panelSectionHeader.border" = scheme.withHashtag.base01;

            "statusBar.background" = scheme.withHashtag.base00;
            "statusBar.foreground" = scheme.withHashtag.base05;
            "statusBar.border" = scheme.withHashtag.base01;
            "statusBar.debuggingBackground" = scheme.withHashtag.base09;
            "statusBar.debuggingForeground" = scheme.withHashtag.base00;
            "statusBar.debuggingBorder" = scheme.withHashtag.base09;
            "statusBar.noFolderBackground" = scheme.withHashtag.base00;
            "statusBar.noFolderForeground" = scheme.withHashtag.base05;
            "statusBar.noFolderBorder" = scheme.withHashtag.base01;
            "statusBarItem.activeBackground" = scheme.withHashtag.base02;
            "statusBarItem.hoverBackground" = scheme.withHashtag.base02;
            "statusBarItem.prominentForeground" = scheme.withHashtag.base05;
            "statusBarItem.prominentBackground" = scheme.withHashtag.base02;
            "statusBarItem.prominentHoverBackground" = scheme.withHashtag.base03;
            "statusBarItem.remoteBackground" = scheme.withHashtag.base0D;
            "statusBarItem.remoteForeground" = scheme.withHashtag.base00;
            "statusBarItem.errorBackground" = scheme.withHashtag.base08;
            "statusBarItem.errorForeground" = scheme.withHashtag.base00;
            "statusBarItem.warningBackground" = scheme.withHashtag.base0A;
            "statusBarItem.warningForeground" = scheme.withHashtag.base00;
            "statusBarItem.compactHoverBackground" = scheme.withHashtag.base02;
            "statusBarItem.focusBorder" = scheme.withHashtag.base0D;

            "titleBar.activeBackground" = scheme.withHashtag.base00;
            "titleBar.activeForeground" = scheme.withHashtag.base05;
            "titleBar.inactiveBackground" = scheme.withHashtag.base00;
            "titleBar.inactiveForeground" = scheme.withHashtag.base03;
            "titleBar.border" = scheme.withHashtag.base01;

            "menubar.selectionForeground" = scheme.withHashtag.base05;
            "menubar.selectionBackground" = scheme.withHashtag.base02;
            "menubar.selectionBorder" = "${scheme.withHashtag.base02}00";
            "menu.foreground" = scheme.withHashtag.base05;
            "menu.background" = scheme.withHashtag.base01;
            "menu.selectionForeground" = scheme.withHashtag.base05;
            "menu.selectionBackground" = scheme.withHashtag.base02;
            "menu.selectionBorder" = "${scheme.withHashtag.base02}00";
            "menu.separatorBackground" = scheme.withHashtag.base02;
            "menu.border" = scheme.withHashtag.base02;

            "commandCenter.foreground" = scheme.withHashtag.base05;
            "commandCenter.activeForeground" = scheme.withHashtag.base05;
            "commandCenter.background" = scheme.withHashtag.base01;
            "commandCenter.activeBackground" = scheme.withHashtag.base02;
            "commandCenter.border" = scheme.withHashtag.base02;
            "commandCenter.inactiveForeground" = scheme.withHashtag.base03;
            "commandCenter.inactiveBorder" = scheme.withHashtag.base02;
            "commandCenter.activeBorder" = scheme.withHashtag.base02;

            "notificationCenter.border" = scheme.withHashtag.base02;
            "notificationCenterHeader.foreground" = scheme.withHashtag.base05;
            "notificationCenterHeader.background" = scheme.withHashtag.base01;
            "notificationToast.border" = scheme.withHashtag.base02;
            "notifications.foreground" = scheme.withHashtag.base05;
            "notifications.background" = scheme.withHashtag.base01;
            "notifications.border" = scheme.withHashtag.base02;
            "notificationLink.foreground" = scheme.withHashtag.base0D;
            "notificationsErrorIcon.foreground" = scheme.withHashtag.base08;
            "notificationsWarningIcon.foreground" = scheme.withHashtag.base0A;
            "notificationsInfoIcon.foreground" = scheme.withHashtag.base0D;

            "banner.background" = scheme.withHashtag.base01;
            "banner.foreground" = scheme.withHashtag.base05;
            "banner.iconForeground" = scheme.withHashtag.base0D;

            "extensionButton.prominentForeground" = scheme.withHashtag.base00;
            "extensionButton.prominentBackground" = scheme.withHashtag.base0D;
            "extensionButton.prominentHoverBackground" = scheme.withHashtag.base16;
            "extensionButton.background" = scheme.withHashtag.base0D;
            "extensionButton.foreground" = scheme.withHashtag.base00;
            "extensionButton.hoverBackground" = scheme.withHashtag.base16;
            "extensionButton.separator" = "${scheme.withHashtag.base00}40";
            "extensionBadge.remoteBackground" = scheme.withHashtag.base0D;
            "extensionBadge.remoteForeground" = scheme.withHashtag.base00;
            "extensionIcon.starForeground" = scheme.withHashtag.base0A;
            "extensionIcon.verifiedForeground" = scheme.withHashtag.base0B;
            "extensionIcon.preReleaseForeground" = scheme.withHashtag.base09;
            "extensionIcon.sponsorForeground" = scheme.withHashtag.base08;

            "quickInput.background" = scheme.withHashtag.base00;
            "quickInput.foreground" = scheme.withHashtag.base05;
            "quickInputList.focusBackground" = scheme.withHashtag.base02;
            "quickInputList.focusForeground" = scheme.withHashtag.base05;
            "quickInputList.focusIconForeground" = scheme.withHashtag.base05;
            "quickInputTitle.background" = scheme.withHashtag.base01;

            "keybindingLabel.background" = scheme.withHashtag.base02;
            "keybindingLabel.foreground" = scheme.withHashtag.base05;
            "keybindingLabel.border" = scheme.withHashtag.base03;
            "keybindingLabel.bottomBorder" = scheme.withHashtag.base03;

            "keybindingTable.headerBackground" = scheme.withHashtag.base01;
            "keybindingTable.rowsBackground" = scheme.withHashtag.base00;

            "terminal.background" = scheme.withHashtag.base00;
            "terminal.foreground" = scheme.withHashtag.base05;
            "terminal.border" = scheme.withHashtag.base01;
            "terminal.selectionBackground" = "${scheme.withHashtag.base02}80";
            "terminal.selectionForeground" = scheme.withHashtag.base05;
            "terminal.inactiveSelectionBackground" = "${scheme.withHashtag.base02}40";
            "terminal.findMatchBackground" = "${scheme.withHashtag.base09}80";
            "terminal.findMatchBorder" = scheme.withHashtag.base09;
            "terminal.findMatchHighlightBackground" = "${scheme.withHashtag.base09}40";
            "terminal.findMatchHighlightBorder" = "${scheme.withHashtag.base09}00";
            "terminalCursor.background" = scheme.withHashtag.base00;
            "terminalCursor.foreground" = scheme.withHashtag.base05;
            "terminal.dropBackground" = "${scheme.withHashtag.base02}80";
            "terminal.tab.activeBorder" = scheme.withHashtag.base0D;
            "terminalCommandDecoration.defaultBackground" = scheme.withHashtag.base03;
            "terminalCommandDecoration.successBackground" = scheme.withHashtag.base0B;
            "terminalCommandDecoration.errorBackground" = scheme.withHashtag.base08;
            "terminalOverviewRuler.cursorForeground" = scheme.withHashtag.base05;
            "terminalOverviewRuler.findMatchForeground" = "${scheme.withHashtag.base09}80";
            "terminal.ansiBlack" = scheme.withHashtag.base00;
            "terminal.ansiRed" = scheme.withHashtag.base08;
            "terminal.ansiGreen" = scheme.withHashtag.base0B;
            "terminal.ansiYellow" = scheme.withHashtag.base0A;
            "terminal.ansiBlue" = scheme.withHashtag.base0D;
            "terminal.ansiMagenta" = scheme.withHashtag.base0E;
            "terminal.ansiCyan" = scheme.withHashtag.base0C;
            "terminal.ansiWhite" = scheme.withHashtag.base05;
            "terminal.ansiBrightBlack" = scheme.withHashtag.base03;
            "terminal.ansiBrightRed" = scheme.withHashtag.base12;
            "terminal.ansiBrightGreen" = scheme.withHashtag.base14;
            "terminal.ansiBrightYellow" = scheme.withHashtag.base13;
            "terminal.ansiBrightBlue" = scheme.withHashtag.base16;
            "terminal.ansiBrightMagenta" = scheme.withHashtag.base17;
            "terminal.ansiBrightCyan" = scheme.withHashtag.base15;
            "terminal.ansiBrightWhite" = scheme.withHashtag.base07;

            "debugToolBar.background" = scheme.withHashtag.base01;
            "debugToolBar.border" = scheme.withHashtag.base02;
            "editor.stackFrameHighlightBackground" = "${scheme.withHashtag.base0A}40";
            "editor.focusedStackFrameHighlightBackground" = "${scheme.withHashtag.base0B}40";
            "editor.inlineValuesForeground" = scheme.withHashtag.base05;
            "editor.inlineValuesBackground" = "${scheme.withHashtag.base0D}40";
            "debugView.exceptionLabelForeground" = scheme.withHashtag.base00;
            "debugView.exceptionLabelBackground" = scheme.withHashtag.base08;
            "debugView.stateLabelForeground" = scheme.withHashtag.base05;
            "debugView.stateLabelBackground" = scheme.withHashtag.base02;
            "debugView.valueChangedHighlight" = scheme.withHashtag.base0D;
            "debugTokenExpression.name" = scheme.withHashtag.base0D;
            "debugTokenExpression.value" = scheme.withHashtag.base05;
            "debugTokenExpression.string" = scheme.withHashtag.base0B;
            "debugTokenExpression.boolean" = scheme.withHashtag.base0E;
            "debugTokenExpression.number" = scheme.withHashtag.base09;
            "debugTokenExpression.error" = scheme.withHashtag.base08;

            "testing.iconFailed" = scheme.withHashtag.base08;
            "testing.iconErrored" = scheme.withHashtag.base08;
            "testing.iconPassed" = scheme.withHashtag.base0B;
            "testing.iconQueued" = scheme.withHashtag.base0A;
            "testing.iconUnset" = scheme.withHashtag.base03;
            "testing.iconSkipped" = scheme.withHashtag.base03;
            "testing.runAction" = scheme.withHashtag.base0B;
            "testing.peekBorder" = scheme.withHashtag.base08;
            "testing.peekHeaderBackground" = "${scheme.withHashtag.base08}20";
            "testing.message.error.decorationForeground" = scheme.withHashtag.base08;
            "testing.message.error.lineBackground" = "${scheme.withHashtag.base08}20";
            "testing.message.info.decorationForeground" = scheme.withHashtag.base0D;
            "testing.message.info.lineBackground" = "${scheme.withHashtag.base0D}20";

            "welcomePage.background" = scheme.withHashtag.base00;
            "welcomePage.tileBackground" = scheme.withHashtag.base01;
            "welcomePage.tileHoverBackground" = scheme.withHashtag.base02;
            "welcomePage.tileBorder" = scheme.withHashtag.base02;
            "welcomePage.progress.foreground" = scheme.withHashtag.base0D;
            "welcomePage.progress.background" = scheme.withHashtag.base02;
            "walkThrough.embeddedEditorBackground" = scheme.withHashtag.base01;

            "gitDecoration.addedResourceForeground" = scheme.withHashtag.base0B;
            "gitDecoration.modifiedResourceForeground" = scheme.withHashtag.base0A;
            "gitDecoration.deletedResourceForeground" = scheme.withHashtag.base08;
            "gitDecoration.renamedResourceForeground" = scheme.withHashtag.base0D;
            "gitDecoration.stageModifiedResourceForeground" = scheme.withHashtag.base0A;
            "gitDecoration.stageDeletedResourceForeground" = scheme.withHashtag.base08;
            "gitDecoration.untrackedResourceForeground" = scheme.withHashtag.base0B;
            "gitDecoration.ignoredResourceForeground" = scheme.withHashtag.base03;
            "gitDecoration.conflictingResourceForeground" = scheme.withHashtag.base09;
            "gitDecoration.submoduleResourceForeground" = scheme.withHashtag.base0C;

            "settings.headerForeground" = scheme.withHashtag.base05;
            "settings.modifiedItemIndicator" = scheme.withHashtag.base0D;
            "settings.dropdownBackground" = scheme.withHashtag.base01;
            "settings.dropdownForeground" = scheme.withHashtag.base05;
            "settings.dropdownBorder" = scheme.withHashtag.base02;
            "settings.dropdownListBorder" = scheme.withHashtag.base02;
            "settings.checkboxBackground" = scheme.withHashtag.base01;
            "settings.checkboxForeground" = scheme.withHashtag.base05;
            "settings.checkboxBorder" = scheme.withHashtag.base03;
            "settings.rowHoverBackground" = scheme.withHashtag.base01;
            "settings.textInputBackground" = scheme.withHashtag.base01;
            "settings.textInputForeground" = scheme.withHashtag.base05;
            "settings.textInputBorder" = scheme.withHashtag.base02;
            "settings.numberInputBackground" = scheme.withHashtag.base01;
            "settings.numberInputForeground" = scheme.withHashtag.base05;
            "settings.numberInputBorder" = scheme.withHashtag.base02;
            "settings.focusedRowBackground" = scheme.withHashtag.base01;
            "settings.focusedRowBorder" = scheme.withHashtag.base0D;
            "settings.sashBorder" = scheme.withHashtag.base02;

            "breadcrumb.foreground" = scheme.withHashtag.base04;
            "breadcrumb.background" = scheme.withHashtag.base00;
            "breadcrumb.focusForeground" = scheme.withHashtag.base05;
            "breadcrumb.activeSelectionForeground" = scheme.withHashtag.base05;
            "breadcrumbPicker.background" = scheme.withHashtag.base01;

            "symbolIcon.arrayForeground" = scheme.withHashtag.base09;
            "symbolIcon.booleanForeground" = scheme.withHashtag.base0E;
            "symbolIcon.classForeground" = scheme.withHashtag.base0A;
            "symbolIcon.colorForeground" = scheme.withHashtag.base09;
            "symbolIcon.constantForeground" = scheme.withHashtag.base09;
            "symbolIcon.constructorForeground" = scheme.withHashtag.base0E;
            "symbolIcon.enumeratorForeground" = scheme.withHashtag.base09;
            "symbolIcon.enumeratorMemberForeground" = scheme.withHashtag.base0C;
            "symbolIcon.eventForeground" = scheme.withHashtag.base09;
            "symbolIcon.fieldForeground" = scheme.withHashtag.base0D;
            "symbolIcon.fileForeground" = scheme.withHashtag.base05;
            "symbolIcon.folderForeground" = scheme.withHashtag.base05;
            "symbolIcon.functionForeground" = scheme.withHashtag.base0D;
            "symbolIcon.interfaceForeground" = scheme.withHashtag.base0C;
            "symbolIcon.keyForeground" = scheme.withHashtag.base0B;
            "symbolIcon.keywordForeground" = scheme.withHashtag.base0E;
            "symbolIcon.methodForeground" = scheme.withHashtag.base0D;
            "symbolIcon.moduleForeground" = scheme.withHashtag.base05;
            "symbolIcon.namespaceForeground" = scheme.withHashtag.base08;
            "symbolIcon.nullForeground" = scheme.withHashtag.base08;
            "symbolIcon.numberForeground" = scheme.withHashtag.base09;
            "symbolIcon.objectForeground" = scheme.withHashtag.base09;
            "symbolIcon.operatorForeground" = scheme.withHashtag.base05;
            "symbolIcon.packageForeground" = scheme.withHashtag.base09;
            "symbolIcon.propertyForeground" = scheme.withHashtag.base05;
            "symbolIcon.referenceForeground" = scheme.withHashtag.base08;
            "symbolIcon.snippetForeground" = scheme.withHashtag.base05;
            "symbolIcon.stringForeground" = scheme.withHashtag.base0B;
            "symbolIcon.structForeground" = scheme.withHashtag.base09;
            "symbolIcon.textForeground" = scheme.withHashtag.base05;
            "symbolIcon.typeParameterForeground" = scheme.withHashtag.base0C;
            "symbolIcon.unitForeground" = scheme.withHashtag.base09;
            "symbolIcon.variableForeground" = scheme.withHashtag.base05;

            "debugIcon.breakpointForeground" = scheme.withHashtag.base08;
            "debugIcon.breakpointDisabledForeground" = scheme.withHashtag.base03;
            "debugIcon.breakpointUnverifiedForeground" = scheme.withHashtag.base03;
            "debugIcon.breakpointCurrentStackframeForeground" = scheme.withHashtag.base0A;
            "debugIcon.breakpointStackframeForeground" = scheme.withHashtag.base03;
            "debugIcon.startForeground" = scheme.withHashtag.base0B;
            "debugIcon.pauseForeground" = scheme.withHashtag.base0D;
            "debugIcon.stopForeground" = scheme.withHashtag.base08;
            "debugIcon.disconnectForeground" = scheme.withHashtag.base08;
            "debugIcon.restartForeground" = scheme.withHashtag.base0B;
            "debugIcon.stepOverForeground" = scheme.withHashtag.base0D;
            "debugIcon.stepIntoForeground" = scheme.withHashtag.base0D;
            "debugIcon.stepOutForeground" = scheme.withHashtag.base0D;
            "debugIcon.continueForeground" = scheme.withHashtag.base0B;
            "debugIcon.stepBackForeground" = scheme.withHashtag.base0D;
            "debugConsole.infoForeground" = scheme.withHashtag.base0D;
            "debugConsole.warningForeground" = scheme.withHashtag.base0A;
            "debugConsole.errorForeground" = scheme.withHashtag.base08;
            "debugConsole.sourceForeground" = scheme.withHashtag.base05;
            "debugConsoleInputIcon.foreground" = scheme.withHashtag.base0D;

            "notebook.editorBackground" = scheme.withHashtag.base00;
            "notebook.cellBorderColor" = scheme.withHashtag.base02;
            "notebook.cellHoverBackground" = scheme.withHashtag.base01;
            "notebook.cellInsertionIndicator" = scheme.withHashtag.base0D;
            "notebook.cellStatusBarItemHoverBackground" = scheme.withHashtag.base02;
            "notebook.cellToolbarSeparator" = scheme.withHashtag.base02;
            "notebook.focusedCellBackground" = scheme.withHashtag.base01;
            "notebook.focusedCellBorder" = scheme.withHashtag.base0D;
            "notebook.focusedEditorBorder" = scheme.withHashtag.base0D;
            "notebook.inactiveFocusedCellBorder" = scheme.withHashtag.base02;
            "notebook.outputContainerBackgroundColor" = scheme.withHashtag.base01;
            "notebook.selectedCellBackground" = scheme.withHashtag.base02;
            "notebook.selectedCellBorder" = scheme.withHashtag.base02;
            "notebook.symbolHighlightBackground" = "${scheme.withHashtag.base0D}40";
            "notebookScrollbarSlider.activeBackground" = scheme.withHashtag.base03;
            "notebookScrollbarSlider.background" = "${scheme.withHashtag.base02}80";
            "notebookScrollbarSlider.hoverBackground" = "${scheme.withHashtag.base03}80";
            "notebookStatusErrorIcon.foreground" = scheme.withHashtag.base08;
            "notebookStatusRunningIcon.foreground" = scheme.withHashtag.base0D;
            "notebookStatusSuccessIcon.foreground" = scheme.withHashtag.base0B;

            "charts.foreground" = scheme.withHashtag.base05;
            "charts.lines" = scheme.withHashtag.base05;
            "charts.red" = scheme.withHashtag.base08;
            "charts.blue" = scheme.withHashtag.base0D;
            "charts.yellow" = scheme.withHashtag.base0A;
            "charts.orange" = scheme.withHashtag.base09;
            "charts.green" = scheme.withHashtag.base0B;
            "charts.purple" = scheme.withHashtag.base0E;
          };

          "editor.tokenColorCustomizations" = {
            "comments" = scheme.withHashtag.base03;
            "strings" = scheme.withHashtag.base0B;
            "keywords" = scheme.withHashtag.base0E;
            "numbers" = scheme.withHashtag.base0A;
            "types" = scheme.withHashtag.base0B;
            "functions" = scheme.withHashtag.base0D;
            "variables" = scheme.withHashtag.base05;
            "textMateRules" = [
              {
                "scope" = [
                  "comment"
                  "punctuation.definition.comment"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base03;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [
                  "comment.block.documentation"
                  "comment.line.documentation"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base03;
                  "fontStyle" = "italic bold";
                };
              }
              {
                "scope" = [
                  "string"
                  "string.quoted"
                  "string.template"
                ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [ "constant.numeric" ];
                "settings"."foreground" = scheme.withHashtag.base0A;
              }
              {
                "scope" = [
                  "constant.language"
                  "constant.language.boolean"
                ];
                "settings"."foreground" = scheme.withHashtag.base0E;
              }
              {
                "scope" = [
                  "constant.other"
                  "constant.character"
                ];
                "settings"."foreground" = scheme.withHashtag.base0E;
              }
              {
                "scope" = [ "constant.character.escape" ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base0D;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [
                  "constant.regexp"
                  "string.regexp"
                ];
                "settings"."foreground" = scheme.withHashtag.base0C;
              }
              {
                "scope" = [
                  "keyword"
                  "keyword.control"
                  "keyword.operator.new"
                  "keyword.operator.expression"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base0E;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [ "keyword.operator" ];
                "settings"."foreground" = scheme.withHashtag.base0E;
              }
              {
                "scope" = [
                  "storage"
                  "storage.type"
                  "storage.modifier"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base0E;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [
                  "entity.name.function"
                  "support.function"
                  "meta.function-call"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base0D;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [
                  "entity.name.function.decorator"
                  "meta.decorator"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base0D;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [
                  "entity.name.type"
                  "entity.name.class"
                  "support.type"
                  "support.class"
                ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [ "entity.name.type.interface" ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [ "entity.other.inherited-class" ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [
                  "variable"
                  "variable.other"
                  "variable.other.readwrite"
                ];
                "settings"."foreground" = scheme.withHashtag.base05;
              }
              {
                "scope" = [ "variable.parameter" ];
                "settings"."foreground" = scheme.withHashtag.base05;
              }
              {
                "scope" = [
                  "variable.language"
                  "variable.language.this"
                  "variable.language.self"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base05;
                  "fontStyle" = "bold";
                };
              }
              {
                "scope" = [ "variable.other.constant" ];
                "settings"."foreground" = scheme.withHashtag.base0E;
              }
              {
                "scope" = [
                  "variable.other.property"
                  "variable.other.object.property"
                ];
                "settings"."foreground" = scheme.withHashtag.base05;
              }
              {
                "scope" = [
                  "entity.name.tag"
                  "entity.name.tag.html"
                  "entity.name.tag.xml"
                  "entity.name.tag.jsx"
                  "entity.name.tag.tsx"
                ];
                "settings"."foreground" = scheme.withHashtag.base08;
              }
              {
                "scope" = [ "entity.other.attribute-name" ];
                "settings"."foreground" = scheme.withHashtag.base0D;
              }
              {
                "scope" = [ "support.type.property-name" ];
                "settings"."foreground" = scheme.withHashtag.base0D;
              }
              {
                "scope" = [ "support.constant.property-value" ];
                "settings"."foreground" = scheme.withHashtag.base0E;
              }
              {
                "scope" = [ "punctuation" ];
                "settings"."foreground" = scheme.withHashtag.base05;
              }
              {
                "scope" = [
                  "markup.heading"
                  "entity.name.section"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base0D;
                  "fontStyle" = "bold";
                };
              }
              {
                "scope" = [ "markup.bold" ];
                "settings"."fontStyle" = "bold";
              }
              {
                "scope" = [ "markup.italic" ];
                "settings"."fontStyle" = "italic";
              }
              {
                "scope" = [ "markup.strikethrough" ];
                "settings"."fontStyle" = "strikethrough";
              }
              {
                "scope" = [ "markup.underline" ];
                "settings"."fontStyle" = "underline";
              }
              {
                "scope" = [
                  "markup.underline.link"
                  "string.other.link"
                ];
                "settings"."foreground" = scheme.withHashtag.base0D;
              }
              {
                "scope" = [
                  "markup.inline.raw"
                  "markup.raw.inline"
                ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [
                  "markup.fenced_code.block"
                  "markup.raw.block"
                  "fenced_code.block.language"
                ];
                "settings"."foreground" = scheme.withHashtag.base05;
              }
              {
                "scope" = [
                  "markup.quote"
                  "markup.quote.markdown"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base03;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [
                  "markup.list"
                  "markup.list.unnumbered"
                  "markup.list.numbered"
                ];
                "settings"."foreground" = scheme.withHashtag.base05;
              }
              {
                "scope" = [ "markup.inserted" ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [ "markup.deleted" ];
                "settings"."foreground" = scheme.withHashtag.base08;
              }
              {
                "scope" = [ "markup.changed" ];
                "settings"."foreground" = scheme.withHashtag.base0A;
              }
              {
                "scope" = [
                  "meta.diff.header"
                  "meta.diff.index"
                  "meta.separator.diff"
                ];
                "settings"."foreground" = scheme.withHashtag.base0D;
              }
              {
                "scope" = [
                  "invalid"
                  "invalid.illegal"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base08;
                  "fontStyle" = "strikethrough";
                };
              }
              {
                "scope" = [ "invalid.deprecated" ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base03;
                  "fontStyle" = "strikethrough";
                };
              }
              {
                "scope" = [ "source.json string.quoted.double.json meta.structure.dictionary.json" ];
                "settings"."foreground" = scheme.withHashtag.base0D;
              }
              {
                "scope" = [
                  "source.json string.quoted.double.json meta.structure.dictionary.json meta.structure.dictionary.value.json string.quoted.double.json"
                ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [ "source.yaml entity.name.tag" ];
                "settings"."foreground" = scheme.withHashtag.base0D;
              }
              {
                "scope" = [ "source.nix" ];
                "settings"."foreground" = scheme.withHashtag.base05;
              }
              {
                "scope" = [
                  "source.nix keyword"
                  "source.nix keyword.control"
                  "source.nix keyword.operator"
                ];
                "settings" = {
                  "foreground" = scheme.withHashtag.base0E;
                  "fontStyle" = "italic";
                };
              }
              {
                "scope" = [ "source.nix string" ];
                "settings"."foreground" = scheme.withHashtag.base0B;
              }
              {
                "scope" = [
                  "source.nix constant"
                  "source.nix constant.numeric"
                ];
                "settings"."foreground" = scheme.withHashtag.base09;
              }
              {
                "scope" = [ "source.nix variable.parameter.function" ];
                "settings"."foreground" = scheme.withHashtag.base08;
              }
              {
                "scope" = [ "source.nix entity.other.attribute-name" ];
                "settings"."foreground" = scheme.withHashtag.base0D;
              }
            ];
          };
        };
      };
    };
}
