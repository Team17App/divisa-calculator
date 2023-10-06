// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../api-services/api_services.dart';
import '../config/config.dart';
import '../models.dart/models.dart';

import '../db/db.dart';
import '../utilities/utilities.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DbController db = Get.find();
  final AllController allctr = Get.find();
  int type = 0;
  late UtilsDialogs dialog;
  @override
  void initState() {
    super.initState();
    allctr.calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    dialog = UtilsDialogs(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Obx(() {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async => await allctr.calculateTotal(),
            child: SingleChildScrollView(
              child: Column(
                children: allctr.listProducts.map((model) {
                  return ItemHomeWidget(
                    model: model,
                    onDeleted: funDeleted,
                  );
                }).toList(),
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              allctr.calculateTotal();

              setState(() {});
            },
            child: Container(
              height: 60,
              color: appBarColor,
              padding: const EdgeInsets.all(10.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                OutlinedButton(
                  onPressed: onPressed,
                  child: Text(
                    Tk.kChange.tr,
                    style: stylesMin.copyWith(color: white),
                  ),
                ),
                const Spacer(),
                Text(
                  '${kTotal.tr}: '.toUpperCase(),
                  style: styles.copyWith(color: white),
                ),
                Text(
                  getTotal(type),
                  style: styles.copyWith(
                    color: white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }

  String getTotal(int type) {
    double total = allctr.total.value;
    String value = allctr.numberFormat(total);
    if (type == 0) {
      value = value;
    } else if (type == 1) {
      value = allctr.numberFormat(total * allctr.ref2.value, sym: 'COP');
    }
    if (type == 2) {
      value = allctr.numberFormat(total * allctr.ref1.value, sym: 'Bs');
    }
    return value;
  }

  onPressed() async {
    final resp = await showModalBottomSheet(
      context: context,
      barrierColor: transparent,
      backgroundColor: transparent,
      isScrollControlled: true,
      builder: (context) {
        return const DialogSelectDivisa();
      },
    );

    debugPrint('DialogSelectDivisa: $resp');

    if (resp is int) {
      try {
        setState(() {
          type = resp;
        });
      } catch (_) {}
    }
  }

  // DANGER
  funDeleted(ProductModel model) async {
    dialog.showPopUpDeleteList(
      title: Tk.titleConfirmDeleteItem.tr,
      content: '"${model.name}"\n\n${Tk.confirmDeletedItem.tr}',
      onConfirm: () {
        Get.back();
        funConfirmDeleted(model);
      },
    );
  }

  funConfirmDeleted(ProductModel model) async {
    await allctr.deleteProduct(model);
    setState(() {});
    try {
      if (CheckPlatform.isModeMobile) {
        Utils.toast(kMsgProductDeleted.tr);
      } else {
        Get.snackbar(
          kProductDeleted.tr,
          kMsgProductDeleted.tr,
          colorText: white,
          duration: const Duration(seconds: 2),
          backgroundColor: black.withOpacity(0.54),
        );
      }
    } on Exception catch (_) {}
  }
}
