part of lists_engine;

/// Wraps an decryption attempt.
class DecryptionResult {
  /// The reuslt of the decryption.
  ///
  /// May be the same before the decryption was attempted if failed.
  ///
  /// Will contain the decrypted data if successful.
  final IndexLink result;

  /// Whether the decryption was successful.
  final bool succeeded;

  /// Whether an error occured during the decryption.
  bool get failed => !succeeded;

  /// Wraps an decryption attempt.
  DecryptionResult(this.result, this.succeeded);
}
