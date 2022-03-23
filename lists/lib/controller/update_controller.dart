part of controllers;

final updaterProvider = ChangeNotifierProvider((ref) => UpdateProvider());

class UpdateProvider extends ChangeNotifier {
  UpdateStatus _status = UpdateStatus.idle;
  int _progress = 0;

  bool get updateAvailable => Updater.updateAvailable;
  String get downloadUrl => Updater.setupDownloadUrl;
  String get latestVersionName => Updater.latestVersionName;

  UpdateStatus get status => _status;
  int get progress => _progress;

  _updateProgress(int p0, int p1) {
    int progress = (p0 / p1 * 100).floor();
    if (progress == _progress) return;
    _progress = progress;

    notifyListeners();
  }

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

enum UpdateStatus { error, downloading, done, idle }

extension UpdateStatusExt on UpdateStatus {
  bool get isDownloading => this == UpdateStatus.downloading;
  bool get isDone => this == UpdateStatus.done;
  bool get isError => this == UpdateStatus.error;
  bool get isIdle => this == UpdateStatus.idle;
}
