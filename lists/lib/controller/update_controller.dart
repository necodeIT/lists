part of controllers;

/// Provider for updating the app.
final updaterProvider = ChangeNotifierProvider((ref) => UpdateProvider());

/// Provider for updating the app.
class UpdateProvider extends ChangeNotifier {
  UpdateStatus _status = UpdateStatus.idle;
  int _progress = 0;

  /// Whether a new update is available.
  bool get updateAvailable => Updater.updateAvailable;

  /// The url to download the update from.
  String get downloadUrl => Updater.setupDownloadUrl;

  /// The version of the update.
  String get latestVersionName => Updater.latestVersionName;

  /// The status of the update.
  UpdateStatus get status => _status;

  /// The progress of the update.
  int get progress => _progress;

  _updateProgress(int p0, int p1) {
    int progress = (p0 / p1 * 100).floor();
    if (progress == _progress) return;
    _progress = progress;

    notifyListeners();
  }

  /// Updates the app.
  void upgrade(VoidCallback onError) async {
    if (status.isDownloading || status.isDone) return;

    _status = UpdateStatus.downloading;
    notifyListeners();

    var f = await Updater.upgrade(_updateProgress);

    _status = await f.exists() ? UpdateStatus.done : UpdateStatus.error;
    _status = UpdateStatus.error;
    notifyListeners();

    if (_status.isError) {
      onError();
    } else {
      await Process.start(f.path, []);
      exit(0);
    }
  }
}

/// Status of the update.
enum UpdateStatus {
  /// The updated failed.
  error,

  /// The update is downloading.
  downloading,

  /// The update is done.
  done,

  /// The update is idle.
  idle,
}

/// Extension for [UpdateStatus].
extension UpdateStatusExt on UpdateStatus {
  /// Whether the update is downloading.
  bool get isDownloading => this == UpdateStatus.downloading;

  /// Whether the update is done.
  bool get isDone => this == UpdateStatus.done;

  /// Whether the update resulted in an error.
  bool get isError => this == UpdateStatus.error;

  /// Whether the updater is idle.
  bool get isIdle => this == UpdateStatus.idle;
}
