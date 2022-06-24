part of lists_engine;

/// Wraps an decryption attempt.
class DecryptionResult {
  /// The reuslt of the decryption.
  ///
  /// Will contain the decrypted data if successful or be null if failed.
  final IndexLink? result;

  /// Whether the decryption was successful.
  final bool succeeded;

  /// Whether a error occured during the decryption.
  bool get failed => !succeeded;

  /// Wraps a decryption attempt with [succeeded] set to false.
  DecryptionResult.failed()
      : succeeded = false,
        result = null;

  /// Wraps a decryption attempt with [succeeded] set to true.
  DecryptionResult.succeeded(this.result) : succeeded = true;
}
