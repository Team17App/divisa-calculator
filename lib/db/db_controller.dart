import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'db_repository.dart';

class DbController extends GetxController {
  /// instance DB
  late Database database;

  /// is ok instance DB
  var inicialice = false.obs;

  @override
  void onInit() {
    super.onInit();
    // xxx
    _initSembast();
  }

  Future _initSembast() async {
    const String nameDB = "divisas.db"; // HERE CHANGE NAME;
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, nameDB);
    debugPrint(databasePath);
    final db = await databaseFactoryIo.openDatabase(databasePath);
    database = db;
    inicialice.value = true;
    update();
  }

  Future<List<Map<String, dynamic>>> getAllJsons() async {
    final list = await DBRepository().getAllJsons();
    return list;
  }

  /// DB insert item.
  /// Not necesary id.
  /// return id.
  Future<int> insertJson(Map<String, dynamic> json) async {
    final id = await DBRepository().insert(json);
    return id;
  }

  Future updateJson(Object? id, Map<String, dynamic> json) async {
    await DBRepository().update(id, json);
  }

  Future deleteJson(int id) async {
    await DBRepository().delete(id);
  }

  Future<Map<String, dynamic>?> getMapById(int id,
      [String keyID = 'id']) async {
    try {
      final list = await DBRepository().getAllJsons();
      final map = list.firstWhere((item) => item[keyID] == id);
      return map;
    } catch (_) {
      return null;
    }
  }
}
