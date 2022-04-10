part of controllers;

/// Provides the current locale.
final localeProvider = ChangeNotifierProvider((ref) => LocaleProvider());

/// Provides the current locale.
class LocaleProvider extends ChangeNotifier {
  /// The current locale.
  Locale get locale => Settings.language;

  /// Sets the current locale.
  void load(Locale? locale) {
    if (locale == null) return;

    log("Locale changed to $locale");

    Settings.setLanguage(locale);

    notifyListeners();
  }
}
