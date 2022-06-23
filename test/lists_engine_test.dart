import 'package:flutter_test/flutter_test.dart';

import 'package:lists_engine/lists_engine.dart';

void main() async {
  var protectedMetaData = CollectionMetaData(name: "Protected Catgirl", protected: true, size: 1);
  var protectedCollection = Collection(name: "Protected Catgirl", content: {"catgirl": "yes"});
  var protectedLink = IndexLink(collection: protectedCollection, metaData: protectedMetaData);
  const protectedPassword = "supersecret";

  var unprotectedMetaData = CollectionMetaData(name: "Catgirl", protected: false, size: 1);
  var unprotectedCollection = Collection(name: "Catgirl", content: {"catgirl": "yes"});
  var unprotectedLink = IndexLink(collection: unprotectedCollection, metaData: unprotectedMetaData);

  var index = {protectedMetaData.name: protectedMetaData, unprotectedMetaData.name: unprotectedMetaData};

  test("Save index", () async {
    await IndexDisk.saveIndex(index);
  });

  // TODO: load index thingy
  // test("Load index", () async {
  //   await IndexDisk.loadIndex();

  //   expect(IndexDisk.data, isNotNull);
  //   expect(IndexDisk.data, index);
  // });

  test("Save unprotected collection", () async {
    await CollectionDisk.saveCollection(unprotectedLink, kUnprotectedPassword);
  });

  test("Save protected collection", () async {
    await CollectionDisk.saveCollection(protectedLink, protectedPassword);
  });

  test("Load unprotected collection", () async {
    var result = await CollectionDisk.loadCollection(unprotectedMetaData, kUnprotectedPassword);

    expect(result.succeeded, isTrue);
    expect(result.result, isNotNull);
    expect(result.result!.collection, unprotectedCollection);
    expect(result.result!.metaData, unprotectedMetaData);
  });

  test("Load protected collection", () async {
    var result = await CollectionDisk.loadCollection(protectedMetaData, protectedPassword);

    expect(result.succeeded, isTrue);
    expect(result.result, isNotNull);
    expect(result.result!.collection, protectedCollection);
    expect(result.result!.metaData, protectedMetaData);
  });

  test("Load collection invalid password", () async {
    var result = await CollectionDisk.loadCollection(protectedMetaData, kUnprotectedPassword);

    expect(result.failed, isTrue);
    expect(result.result, isNull);
  });
}
