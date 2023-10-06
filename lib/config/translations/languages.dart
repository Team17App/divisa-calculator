import 'package:get/get.dart';

import 'en.dart';
import 'es.dart';

/// Clase encargada de la configuracion de idiomas de la aplicación.
class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es_ES': Es().messages,
        'en_US': En().messages,
      };
}
