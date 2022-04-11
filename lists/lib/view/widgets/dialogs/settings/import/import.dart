part of '../settings_dialog.dart';

/// Import settings.
class ImportOptions extends LocalizedWidget {
  /// Import settings.
  // const ImportOptions({Key? key, required this.switchView}) : super(key: key);
  const ImportOptions({Key? key}) : super(key: key);

  /// Callback in order switch to another view inside the settings dialog.
  // final Function(Widget, String) switchView;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      initiallyExpanded: false,
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_arrow_import_24_filled, text: t.import),
      content: Consumer(builder: (context, ref, _) {
        var importer = ref.watch(importProvider);
        ref.watch(localeProvider);
        var t = AppLocalizations.of(context)!;
        return Column(
          children: [
            // SettingsContainer(
            //   title: NcTitleText("Export list to file"),
            //   onTap: () {},
            //   trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
            // ),
            SettingsContainer(
              title: NcTitleText(t.importListFromFile),
              // onTap: () => switchView(
              //   Column(
              //     children: [
              //       for (var collection in DB.collections) SettingsListTile(collection: collection),
              //     ],
              //   ),
              //   t.importListFromFile,
              // ),
              trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
            ),
            if (Platform.isWindows)
              SettingsContainer(
                title: NcTitleText(t.importListsFromOlderVersions),
                onTap: importer.state.isImporting ? null : importer.importFromOlderVersions,
                trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
              ),
            if (importer.state.isImporting)
              InfoBar(
                title: NcTitleText(t.importing),
                action: SizedBox(
                  width: 15,
                  height: 15,
                  child: ProgressRing(
                    backgroundColor: Colors.transparent,
                    activeColor: adaptiveAccentColor,
                    strokeWidth: 3,
                  ),
                ),
              ),
            if (importer.state.isImporting)
              if (importer.state.isError)
                InfoBar(
                  title: NcTitleText(t.importErrorTitle),
                  content: NcBodyText(
                    t.importErrorDesc,
                    overflow: TextOverflow.visible,
                  ),
                  severity: InfoBarSeverity.error,
                  isLong: true,
                ),

            InfoBar(
              title: NcCaptionText(t.importingIsNotImplementedYet),
              severity: InfoBarSeverity.warning,
            ),
          ],
        );
      }),
    );
  }
}
