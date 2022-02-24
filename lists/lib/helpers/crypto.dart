import 'dart:convert';

import 'package:crypto/crypto.dart';

sha256Hash(String value) {
  var bytes = utf8.encode(value);
  var digest = sha256.convert(bytes);

  return digest.toString();
}
