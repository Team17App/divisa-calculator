export 'home_main_page.dart';
export 'home_page.dart';
export 'settings_page.dart';

// ===============
enum ScreenNames {
  main('/'),
  onboarding('/onboarding'),
  homeMain('/home_main'),
  home('/home'),
  createProduct('/createProduct'),
  settings('/settings'),
  none('/loading');

  const ScreenNames(this.route);
  final String route;
}
