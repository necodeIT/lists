library lists_engine;

export 'package:lists_engine/models/collection_model.dart';
export 'package:lists_engine/models/collection_meta_data_model.dart';
export 'package:lists_engine/models/link_model.dart';
export 'package:lists_engine/models/settings_model.dart';

import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lists_engine/models/collection_model.dart';
import 'package:lists_engine/models/link_model.dart';
import 'package:nekolib_utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:aes_crypt/aes_crypt.dart';
import 'models/collection_meta_data_model.dart';
import 'package:lists_engine/models/settings_model.dart';

part 'models/decryption_result_model.dart';

part 'providers/index_provider.dart';

part 'disk/disk.dart';
part 'disk/index_disk.dart';
part 'disk/collection_disk.dart';
part 'disk/settings_disk.dart';

/// Indexes [CollectionMetaData] and [Collection]s.
typedef Index = Map<String, CollectionMetaData>;

/// Password used when a [Collection] is not protected.
const kUnprotectedPassword = "#&:nz#}!l3fr~`[}";

/// The name of the system theme.
const kSystemTheme = "System";
