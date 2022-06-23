library lists_engine;

export 'package:lists_engine/models/model_collection.dart';
export 'package:lists_engine/models/model_collection_meta_data.dart';
export 'package:lists_engine/models/model_link.dart';

import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lists_engine/models/model_collection.dart';
import 'package:lists_engine/models/model_link.dart';
import 'package:nekolib_utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:aes_crypt/aes_crypt.dart';

import 'models/model_collection_meta_data.dart';

part 'models/decryption_result.dart';

part 'providers/provider_index.dart';

part 'disk/disk.dart';
part 'disk/index_disk.dart';
part 'disk/collection_disk.dart';

/// Indexes [CollectionMetaData] and [Collection]s.
typedef Index = Map<String, CollectionMetaData>;

/// Password used when a [Collection] is not protected.
const kUnprotectedPassword = "#&:nz#}!l3fr~`[}";