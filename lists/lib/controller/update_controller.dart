part of controllers;

final updaterProvider = ChangeNotifierProvider((ref) => UpdateProvider());

class UpdateProvider extends ChangeNotifier {
  bool _error = false;
  bool _downloading = false;
  bool _done = false;
  int _progress = 0;

  bool get updateAvailable => Updater.updateAvailable;
  String get downloadUrl => Updater.setupDownloadUrl;
  String get latestVersionName => Updater.latestVersionName;

  bool get error => _error;
  bool get downloading => _downloading;
  bool get done => _done;
  int get progress => _progress;

  _updateProgress(int p0, int p1) {
    int progress = (p0 / p1 * 100).floor();
    if (progress == _progress) return;
    _progress = progress;

    notifyListeners();
  }

  void upgrade(VoidCallback onError) async {
    if (_downloading) return;

    _downloading = true;
    notifyListeners();

    var f = await Updater.upgrade(_updateProgress);

    _error = !await File(f).exists();

    _done = true;
    notifyListeners();

    if (error) {
      onError();
    } else {
      await Process.start(f, []);
      exit(0);
    }
  }
}
