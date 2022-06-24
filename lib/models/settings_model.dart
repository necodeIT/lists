import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lists_engine/lists_engine.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

/// Settings for the app.
@freezed
class Settings with _$Settings {
  const Settings._();

  /// Settings for the app.
  const factory Settings({
    /// The name of the theme the user has selected.
    required String theme,

    /// The language the user has selected.
    required String language,

    /// Whether to sync the accent color with the system.
    required bool adaptiveAccent,

    /// Whether to sync the app with the cloud.
    required bool sync,
  }) = _Settings;

  /// Settings for the app from json.
  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  /// Whether [kSystemTheme] is the current theme.
  bool get systemThemeActive => theme == kSystemTheme;
}
