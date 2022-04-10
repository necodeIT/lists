import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lists/controller/controller.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:lists/view/widgets/localized_widget.dart';
import 'package:nekolib_ui/core.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

/// Loading widget for the app.
class AppLoader extends StatelessWidget {
  /// Loading widget for the app.
  const AppLoader({Key? key}) : super(key: key);

  /// Loading widget for the app.
  static Widget builder(context) => AppLoader();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(builder: (context, ref, _) {
        var lang = ref.watch(localeProvider);

        return FluentApp(
          localizationsDelegates: const [
            LocaleNamesLocalizationsDelegate(),
            ...AppLocalizations.localizationsDelegates,
          ],
          locale: lang.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            brightness: brightness,
            scaffoldBackgroundColor: secondaryColor,
            accentColor: adaptiveAccentColor,
          ),
          home: _LoadingIndicator(),
        );
      }),
    );
  }
}

class _LoadingIndicator extends LocalizedWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProgressRing(
            backgroundColor: Colors.transparent,
          ),
          NcSpacing.xl(),
          NcCaptionText(t.loadingData, fontSize: 20),
        ],
      ),
    );
  }
}
