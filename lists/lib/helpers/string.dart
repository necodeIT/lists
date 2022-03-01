import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

extension StringExtensions on String {
  bool containsIgnoreCase(String other) => toLowerCase().contains(other.toLowerCase());

  String sha256() {
    var bytes = utf8.encode(this);
    var digest = crypto.sha256.convert(bytes);

    return digest.toString();
  }
}
