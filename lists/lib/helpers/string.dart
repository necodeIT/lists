import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

/// String helper functions.
extension StringExtensions on String {
  /// Returns if a this string contains an[other] string.
  /// While chacking for a substring, it is case-insensitive.
  bool containsIgnoreCase(String other) => toLowerCase().contains(other.toLowerCase());

  /// Returns the sha256 hash of this string.
  String sha256() {
    var bytes = utf8.encode(this);
    var digest = crypto.sha256.convert(bytes);

    return digest.toString();
  }
}
