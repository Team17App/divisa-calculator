import 'package:divisa_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../api-services/api_services.dart';
import '../config/config.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AllController allctr = Get.find();

  List<TextEditingController> dollarToBs = [
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> dollarToCOP = [
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> bsToCOP = [
    TextEditingController(),
    TextEditingController()
  ];

  List<TextEditingController> ctrs = [
    TextEditingController(),
    TextEditingController()
  ];

  int type = 0;
  final List<String> listTag = ['USD-USD', 'USD-COP', 'USD-Bs', 'COP-Bs'];

  @override
  void initState() {
    //
    init();
    super.initState();
  }

  init() async {
    //
    dollarToBs.first.text = allctr.ref1.value.toStringAsFixed(2);
    dollarToBs.last.text = (await allctr.getSharedRef(0)).toStringAsFixed(2);
    //
    dollarToCOP.first.text = allctr.ref2.value.toStringAsFixed(2);
    dollarToCOP.last.text = (await allctr.getSharedRef(1)).toStringAsFixed(2);
    //
    bsToCOP.first.text = allctr.ref3.value.toStringAsFixed(2);
    bsToCOP.last.text = (await allctr.getSharedRef(2)).toStringAsFixed(2);
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            // space
            const SizedBox(height: 20),
            // $ -> Bs
            WidgetConvertTo(
              ctrs: dollarToBs,
              tag: 'USD\nBs',
              onWrite: (value) {
                final rf = allctr.ref1.value;
                dollarToBs.last.text = rf.toStringAsFixed(2);
              },
            ),

            const SizedBox(height: 20),
            // $ -> COP
            WidgetConvertTo(
              ctrs: dollarToCOP,
              tag: 'USD\nCOP',
              onWrite: (value) {
                final rf = allctr.ref2.value;
                dollarToCOP.last.text = rf.toStringAsFixed(2);
              },
            ),

            const SizedBox(height: 20),
            // Bs -> COP
            WidgetConvertTo(
              ctrs: bsToCOP,
              tag: 'Bs\nCOP',
              onWrite: (value) {
                final rf = allctr.ref3.value;
                bsToCOP.last.text = rf.toStringAsFixed(2);
              },
            ),
            // space
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onSaved,
                      icon: const Icon(Icons.save),
                      label: Text(Tk.kSave.tr),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onSavedTemp,
                      icon: const Icon(Icons.save_alt_outlined),
                      label: Text(Tk.kSavedTemp.tr),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(children: [
              const SizedBox(width: 20),
              Expanded(
                child: EditTextWidget(
                  controller: ctrs.first,
                  hintText: listTag[type],
                  textAlign: TextAlign.center,
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    double p = double.parse(value.isEmpty ? '0.0' : value);
                    if (type == 0) {
                      // nothing
                    }
                    if (type == 1) {
                      p = p * allctr.ref2.value;
                    }
                    if (type == 2) {
                      p = p * allctr.ref1.value;
                    }
                    if (type == 3) {
                      final c = allctr.ref3.value;
                      p = p / (c != 0 ? c : 1);
                    }
                    ctrs.last.text = p.toStringAsFixed(2);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: EditTextWidget(
                  controller: ctrs.last,
                  textAlign: TextAlign.center,
                  textInputType: TextInputType.number,
                  enabled: false,
                ),
              ),
              const SizedBox(width: 20),
            ]),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                onPressed: onChangeCurrency,
                child: Text(Tk.kChange.tr),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  onSavedTemp() async {
    String s1 = dollarToBs.first.text;
    double v1 = s1.isEmpty ? 1.0 : s1.toDouble;
    allctr.ref1.value = v1;

    // re2
    s1 = dollarToCOP.first.text;
    v1 = s1.isEmpty ? 1.0 : s1.toDouble;
    allctr.ref2.value = v1;

    // ref3
    s1 = bsToCOP.first.text;
    v1 = s1.isEmpty ? 1.0 : s1.toDouble;
    allctr.ref3.value = v1;

    Get.snackbar(
      Tk.kSave.tr,
      Tk.kSavedTemp.tr,
      snackPosition: SnackPosition.BOTTOM,
      // ignore: use_build_context_synchronously
      colorText: isThemeMode(context, dark: white, light: black),
      backgroundColor: cardColor,
    );
  }

  onSaved() async {
    String s1 = dollarToBs.first.text;
    double v1 = s1.isEmpty ? 1.0 : s1.toDouble;
    await allctr.savedSharedRef(v1, 0);
    dollarToBs.last.text = v1.toStringAsFixed(2);
    // re2
    s1 = dollarToCOP.first.text;
    v1 = s1.isEmpty ? 1.0 : s1.toDouble;
    await allctr.savedSharedRef(v1, 1);
    dollarToCOP.last.text = v1.toStringAsFixed(2);
    // ref3
    s1 = bsToCOP.first.text;
    v1 = s1.isEmpty ? 1.0 : s1.toDouble;
    await allctr.savedSharedRef(v1, 2);
    bsToCOP.last.text = v1.toStringAsFixed(2);

    Get.snackbar(
      Tk.kSave.tr,
      Tk.kSaved.tr,
      snackPosition: SnackPosition.BOTTOM,
      // ignore: use_build_context_synchronously
      colorText: isThemeMode(context, dark: white, light: black),
      backgroundColor: cardColor,
    );
  }

  void onChangeCurrency() async {
    final resp = await showModalBottomSheet(
      context: context,
      barrierColor: transparent,
      backgroundColor: transparent,
      isScrollControlled: true,
      builder: (context) {
        return const DialogSelectDivisa(
          list: ['COP-Bs'],
        );
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
}
