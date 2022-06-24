part of lists_engine;

/// Responsible for saving and loading the [Index] file.
class SettingsDisk {
  static Settings? _data;

  /// The loaded [Settings] from disk.
  static Settings? get data => _data;

  /// The name of the file where the [Settings] ared stored.
  static const String settingsFileName = "settings.json";

  /// The file where the [Settings] is stored.
  static Future<File> get settingsFile async {
    var dir = await Disk.appDir;

    var file = File('${dir.path}/$settingsFileName');

    return file;
  }

  /// Saves the [settigns] to the disk.
  static Future<void> saveSettings(Settings settigns) async {
    var file = await settingsFile;

    var json = jsonEncode(settigns);

    await file.writeAsString(json);
  }

  /// Loads the [Settings] from the disk.
  static Future<void> loadSettings() async {
    var file = await settingsFile;

    try {
      var data = await file.readAsString();

      var json = jsonDecode(data);

      _data = Settings.fromJson(json);
    } catch (e) {
      _data = null;
    }
  }
}
