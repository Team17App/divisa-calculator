import 'package:flutter/material.dart';

import '../api-services/api_services.dart';
import '../config/config.dart';
import '../utilities/utils_styles.dart';

class BottomNavBarWidget extends StatelessWidget {
  final double iconSize;
  final void Function(int)? onItemTapped;
  final List<String> icons;
  final List<String> titles;
  const BottomNavBarWidget({
    required this.onItemTapped,
    required this.icons,
    required this.titles,
    this.iconSize = 25.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllController allctr = Get.find();
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        for (int i = 0; i < icons.length; i++)
          BottomNavigationBarItem(
            label: titles[i],
            icon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(
                icons[i],
                width: iconSize,
                height: iconSize,
                color: allctr.selectedIndex.value == i ? white : grey,
              ),
            ),
          ),
      ],
      backgroundColor: appBarColor,
      currentIndex: allctr.selectedIndex.value,
      selectedItemColor: white,
      unselectedItemColor: grey,
      unselectedLabelStyle: stylesSubtitlesCard,
      selectedLabelStyle: stylesTitlesCard,
      onTap: onItemTapped,
    );
  }
}
