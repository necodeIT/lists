import 'dart:convert';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'dart:io';

/// Updates the app.
class Updater {
  /// Used to check for internet connection.
  static final connectivity = Connectivity();

  /// The url of the github api.
  static const githubApiUrl = 'https://api.github.com/repos';

  /// The repo owner of the app.
  static const repoOwner = "necodeIT";

  /// The repo name of the app.
  static const repoName = "lists";

  /// The api url of the github repo.
  static const repoUrl = "$githubApiUrl/$repoOwner/$repoName";

  /// The name of the app.
  static const appName = "Lists";

  /// The current version of the app.
  static const version = "0.0.2";

  static const _versionName = "Alpha";

  /// The current version name of the app.
  static String get versionName => "$_versionName v$version";

  static var _latestVersion = "";
  static var _latestReleaseName = "";
  static var _updateAvailable = false;
  static var _setupDownloadUrl = "";
  static String? _errorMessage;

  /// The latest version available on github of the app.
  static String get latestVersion => _latestVersion;

  /// The latest release name available on github of the app.
  static String get latestVersionName => _latestReleaseName;

  /// Whether a new update is available.
  static bool get updateAvailable => _updateAvailable;

  /// The url to download the update from.
  static String get setupDownloadUrl => _setupDownloadUrl;

  /// Returns an error message.
  /// Returns null if there is no error.
  static String? getErrorMessage() {
    var copy = _errorMessage;
    _errorMessage = null;
    return copy;
  }

  /// Initializes the updater.
  static Future init() async {
    _updateAvailable = await update();
  }

  /// Check for newer release on github
  static Future<bool> update() async {
    if (!await connectivity.checkConnection()) {
      _errorMessage = "Could not check for updates automatically, you may be using an outadet version!";
      return _updateAvailable = false;
    }

    var client = Client();

    try {
      var response = await client.get(Uri.parse("$repoUrl/releases/latest"));
      var json = jsonDecode(response.body);
      _latestVersion = json["tag_name"];
      _latestReleaseName = json["name"];
      // get asset download url with name WindowsSetup.exe
      var asset = json["assets"].firstWhere((asset) => asset["name"] == "WindowsSetup.exe");
      _setupDownloadUrl = asset["browser_download_url"];

      return _updateAvailable = latestVersion != version;
    } catch (e) {
      _errorMessage = "Error checking for upates: $e! If this error persists, please let us know by opening an issue on GitHub";

      return _updateAvailable = false;
    }
  }

  /// Download the setup file to temp folder
  static Future<File> upgrade(Function(int, int)? onReceiveProgress) async {
    var dio = Dio();
    var path = "${Directory.systemTemp.path}/$appName - $latestVersionName Setup.exe";
    await dio.download(_setupDownloadUrl, path, onReceiveProgress: onReceiveProgress);

    return File(path);
  }
}
