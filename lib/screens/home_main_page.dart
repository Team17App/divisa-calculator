// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../db/db.dart';
import '../api-services/api_services.dart';
import '../config/config.dart';
import '../screens/screens.dart';
import '../utilities/utilities.dart';
import '../widgets/widgets.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final DbController db = Get.find();
  final AllController allctr = Get.find();

  final List<Widget> screens = [
    const HomePage(),
    const SizedBox(),
    const SettingsPage(),
  ];

  Future<bool> onWillPop() async {
    if (allctr.selectedIndex.value == 9) {
      return Future.value(false);
    }
    if (allctr.listViewIndex.length > 1) {
      allctr.listViewIndex.removeLast();
      allctr.setIndexPosition = allctr.listViewIndex.last;
      setState(() {});

      return Future.value(false);
    } else {
      return onWillPopExit();
    }
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPopExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime ?? now) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.toast(kMsgBackToExit.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: const Text(APP_NAME),
            actions: [
              IconButton(
                onPressed: () async {
                  setState(() {});
                  await allctr.getSharedRefs();
                  await Future.delayed(const Duration(milliseconds: 100));
                  allctr.calculateTotal();
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: screens[allctr.selectedIndex.value],
          bottomNavigationBar: BottomNavBarWidget(
              icons: const [menu1, icAdd, menu5],
              titles: [Tk.kMenu1.tr, Tk.kAdd.tr, Tk.kMenu5.tr],
              onItemTapped: (index) {
                if (index == 1) {
                  showModalBottomSheet(
                    context: context,
                    barrierColor: transparent,
                    backgroundColor: transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return const DialogAddProduct();
                    },
                  );
                  return;
                }
                allctr.setIndexPosition = index;
                allctr.listViewIndex.add(index);
                setState(() {});
              }),
        );
      }),
    );
  }
}
