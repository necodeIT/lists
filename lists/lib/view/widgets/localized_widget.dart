// ignore_for_file: must_be_immutable

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

/// Provides localized strings for the app.
abstract class LocalizedWidget extends StatelessWidget {
  static AppLocalizations? _t;

  /// Provides localized strings for the app.
  const LocalizedWidget({Key? key}) : super(key: key);

  /// Provides localized strings for the app.
  AppLocalizations get t => _t!;

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    _t ??= AppLocalizations.of(context)!;

    return SizedBox.shrink();
  }
}

/// Provides localized strings for the app.
extension StateLocalization<T extends StatefulWidget> on State<T> {
  /// Provides localized strings for the app.
  AppLocalizations get t => AppLocalizations.of(context)!;
}
