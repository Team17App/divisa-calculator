// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';

import '../config/config.dart';
import '../models.dart/models.dart';
import '../utilities/utilities.dart';

class AllController extends GetxController {
  /// index selected home main
  var selectedIndex = 0.obs;

  /// formate number position
  var formatNumberPosition = true.obs;

  /// symbol
  String symbol = '\$';

  /// Array from widget position  home_main
  var listViewIndex = [0].obs;

  /// Array products
  var listProducts = <ProductModel>[].obs;

  /// value total price
  var total = 0.0.obs;

  /// Dollar to Bs
  var ref1 = 35.0.obs;

  /// Dollar to COP
  var ref2 = 4500.00.obs;

  /// Bs to COP
  var ref3 = 110.00.obs;

  /// Main reference "dollar"
  var refDollar = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    // get data shared
    shared();
    // fake();
  }

  set setIndexPosition(int index) {
    selectedIndex.value = index;
    update();
  }

  Future<void> shared() async {
    final s1 = (await SharedPrefs.getDouble(sharedRef1)) ?? 1.0;
    final s2 = (await SharedPrefs.getDouble(sharedRef2)) ?? 1.0;
    final s3 = (await SharedPrefs.getDouble(sharedRef3)) ?? 1.0;

    ref1.value = s1;
    ref2.value = s2;
    ref3.value = s3;
    update();
  }

  Future<void> savedSharedRef(double value, int key) async {
    if (key == 0) await SharedPrefs.setDouble(sharedRef1, value);
    if (key == 1) await SharedPrefs.setDouble(sharedRef2, value);
    if (key == 2) await SharedPrefs.setDouble(sharedRef3, value);

    if (key == 0) ref1.value = value;
    if (key == 1) ref2.value = value;
    if (key == 2) ref3.value = value;
  }

  Future<double> getSharedRef(int key) async {
    double value = 0.0;
    if (key == 0) value = (await SharedPrefs.getDouble(sharedRef1) ?? 0.0);
    if (key == 1) value = (await SharedPrefs.getDouble(sharedRef2) ?? 0.0);
    if (key == 2) value = (await SharedPrefs.getDouble(sharedRef3) ?? 0.0);

    return value;
  }

  Future<void> getSharedRefs() async {
    ref1.value = (await SharedPrefs.getDouble(sharedRef1) ?? 0.0);
    ref2.value = (await SharedPrefs.getDouble(sharedRef2) ?? 0.0);
    ref3.value = (await SharedPrefs.getDouble(sharedRef3) ?? 0.0);
  }

// delete
  void fake() {
    listProducts.value = List.generate(
      20,
      (index) => ProductModel(
        id: index,
        name: 'Product $index',
        price: index * 10,
        type: 0,
      ),
    );
  }

  calculateTotal() {
    final listPrice = listProducts.map((e) {
      double price = e.price * e.quantity;
      if (e.type == 2) {
        return price / ref1.value;
      } else if (e.type == 1) {
        return price / ref2.value;
      }
      return price;
    }).toList();
    total.value = listPrice.fold(0.0, (p1, p2) => p1 + p2);
  }

  Future<void> deleteProduct(ProductModel product) async {
    // ignore: invalid_use_of_protected_member
    final list = listProducts.value;

    list.removeWhere(
      (e) {
        if (e.id == product.id) debugPrint('DATA: ${e.toJson()}');
        return e.id == product.id;
      },
    );

    listProducts.value = list;

    calculateTotal();
  }

  String numberFormat(double value, {bool showSymbol = true, String? sym}) {
    double n = num.parse(value.toStringAsFixed(2)).toDouble();

    String newPattern = "#,##0.00";
    final kSym = sym ?? symbol;

    var ff = Utils.numberFormatCustom(n, newPattern);
    String resp = formatNumberPosition.value ? "$ff $kSym" : "$kSym $ff";
    resp = showSymbol ? resp : ff;
    return resp;
  }
}
