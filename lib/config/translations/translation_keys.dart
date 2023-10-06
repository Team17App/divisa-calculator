/// Es necesario `importar como`, asi:
///
/// import 'package:sistema_pos/translations/translation_keys.dart' as tk;
///
/// `tk.title.tr` traduce sin parametros
///
/// `tk.withParam` traduce con parametros en las clases `En()` y `Es()`
/// debe colocar el texto `@` seguido del nombre del parametro en el string
///
/// Para llamarlo sobre otras clases simplemente use:
/// `tk.{ttt}.trParams({`'key_del_parametro'`:`'value_del_parametro'`})`
///
/// `tk.withParam.trParams({`'key_del_parametro'`:`'value_del_parametro'`})`

/// ttt
// const kTitle = 'title';
// const kSubtitle = 'subtitle';
// const kWithParam = 'withParam';

/// message back to exit
const kMsgBackToExit = 'msgBackToExit';

/// menu1
const kMenu1 = 'menu1';

/// menu2
const kMenu2 = 'menu2';

/// menu3
const kMenu3 = 'menu3';

/// menu4
const kMenu4 = 'menu4';

/// menu5
const kMenu5 = 'menu5';

/// total
const kTotal = 'total';

/// adds
const kAdd = 'add';

/// name
const kName = 'name';

/// price
const kPrice = 'price';

/// add new product
const kAddProduct = 'addProduct';

/// deleted title
const kDeleted = 'Eliminado';

/// product deleted
const kProductDeleted = 'Procucto eliminado';

/// message product deleted
const kMsgProductDeleted = 'El producto ha sido eliminado';

class Tk {
  /// message back to exit
  static const kMsgBackToExit = 'msgBackToExit';

  /// menu1
  static const kMenu1 = 'kMenu1';

  /// menu2
  static const kMenu2 = 'kMenu2';

  /// menu3
  static const kMenu3 = 'kMenu3';

  /// menu4
  static const kMenu4 = 'kMenu4';

  /// menu5
  static const kMenu5 = 'kMenu5';

  /// total
  static const kTotal = 'kTotal';

  /// adds
  static const kAdd = 'kAdd';

  /// name
  static const kName = 'kName';

  /// price
  static const kPrice = 'kPrice';

  /// edit
  static const kEdit = 'kEdit';

  /// quantity
  static const kQuantity = 'kQuantity';

  /// add new product
  static const kAddProduct = 'kAddProduct';

  /// deleted title
  static const kDeleted = 'kDeleted';

  /// product deleted
  static const kProductDeleted = 'kProductDeleted';

  /// message product deleted
  static const kMsgProductDeleted = 'kMsgProductDeleted';

  /// saved
  static const kSaved = 'kSaved';

  /// save
  static const kSave = 'kSave';

  /// save
  static const kSavedTemp = 'kSaveTemp';

  /// change currency
  static const kChange = 'kChange';

  /// Cancel
  static const tCancel = 'tCancel';

  /// Accept
  static const tAccept = 'tAccept';

  /// title confirm delete item
  static const titleConfirmDeleteItem = 'titleConfirmDeleteItem';

  /// confirm deleted item
  static const confirmDeletedItem = 'confirmDeletedItem';
}
