import 'package:divisa_calculator/utilities/utilities.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';

class DialogSelectDivisa extends StatelessWidget {
  final List<String> list;
  const DialogSelectDivisa({this.list = const [], super.key});

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final colorText = isThemeMode(context, dark: white, light: black);

    return AnimatedContainer(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      duration: const Duration(milliseconds: 300),
      height: 100,
      decoration: BoxDecoration(
        color: grey800,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Wrap(alignment: WrapAlignment.center, children: [
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () => onPressed(0),
              child: Text(
                'USD',
                style: styles.copyWith(color: colorText),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () => onPressed(1),
              child: Text(
                'COP',
                style: styles.copyWith(color: colorText),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () => onPressed(2),
              child: Text(
                'Bs',
                style: styles.copyWith(color: colorText),
              ),
            ),
            const SizedBox(width: 10),
            if (list.isNotEmpty) ...otherWidgetNamesText(list),
          ]),
        ],
      ),
    );
  }

  List<Widget> otherWidgetNamesText(List<String> list) {
    final colorText = isThemeMode(Get.context!, dark: white, light: black);

    int count = 2;
    return list.map(
      (e) {
        count++;
        return OutlinedButton(
          onPressed: () => onPressed(count),
          child: Text(
            e,
            style: styles.copyWith(color: colorText),
          ),
        );
      },
    ).toList();
  }

  onPressed(int i) {
    Get.back(result: i);
  }
}
