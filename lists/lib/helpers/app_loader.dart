import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

/// Displays a loading screen while the app is loading.
Widget appLoader(context) => FluentApp(
      theme: ThemeData(
        brightness: brightness,
        scaffoldBackgroundColor: secondaryColor,
        accentColor: adaptiveAccentColor,
      ),
      home: Container(
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
            NcCaptionText("Loading data...", fontSize: 20),
          ],
        ),
      ),
    );
