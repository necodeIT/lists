import 'package:nekolib_utils/updater.dart';

/// A class that handles the update process.
class Updater extends GitHubUpdater {
  /// A class that handles the update process.
  Updater() : super();

  @override
  String get appName => "Lists";

  @override
  String get currentVersion => "0.0.2";

  @override
  String get linuxFileName => throw UnimplementedError();

  @override
  String get macFileName => throw UnimplementedError();

  @override
  String get repo => "lists";

  @override
  String get repoOwner => "necodeIT";

  @override
  String get windowsFileName => "WindowsSetup.exe";
}

/// Current instance of the updater.
final kUpdater = Updater();
