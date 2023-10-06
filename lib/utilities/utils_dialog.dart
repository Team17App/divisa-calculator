import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../utilities/utilities.dart';

class UtilsDialogs {
  BuildContext context;
  String? title;
  String? textContent;
  Widget? actionsTrailing;
  Widget? actionsLeading;
  String? assetsError;
  TextStyle? styleTitle;

  UtilsDialogs(this.context,
      {this.title,
      this.textContent,
      this.actionsTrailing,
      this.actionsLeading,
      this.assetsError,
      this.styleTitle});

// esto es para la decoración del dialogo
  _decoration({Color? colorBG}) => BoxDecoration(
        color: colorBG ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      );

// esto es para la decoración del dialogo "la linea blanca esa que representa que puede ser arrastrado"
  _widget1({bool right = false}) {
    final ss = MediaQuery.of(context).size.width * 0.2;
    //final Widget expand = SizedBox(height: 4, child: Spacer());
    final Widget expand = SizedBox(height: 4, width: ss - 70);
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          expand,
          Container(
            width: 40,
            height: 4.5,
            decoration: BoxDecoration(
                color: Theme.of(context).iconTheme.color,
                borderRadius: const BorderRadius.all(Radius.circular(50))),
          ),
          if (right) expand,
        ],
      ),
    );
  }

// un dialogo simple para mensajes simples pero manteniendo el estilo de los demás
  showMessage({
    void Function()? onAccept,
    void Function()? onCancel,
    String? replaceMessage,
    TextAlign? textAlign,
    String? strCancel,
    String? strAccept,
    Color? colorAccept,
    double width = 100,
    double height = 45,
    EdgeInsets? padding,
    EdgeInsets? margin,
    TextStyle? styleTextButton,
    BoxDecoration? decoration,
    bool enableCopyClipboard = false,
    Widget? childContent,
  }) {
    final msg = replaceMessage ?? textContent;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: _decoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            _widget1(right: true),
            const SizedBox(height: 20),
            // title
            if (title != null)
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Text(
                    title!,
                    style: styleTitle ??
                        const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            const SizedBox(height: 10),
            // message
            if (msg != null)
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onLongPress: enableCopyClipboard
                          ? () => Utils.clipboardData(msg)
                          : null,
                      child: childContent ??
                          Text(
                            msg,
                            textAlign: textAlign ?? TextAlign.start,
                          ),
                    ),
                  ),
                ],
              ),
            if (onCancel != null || onAccept != null)
              const SizedBox(height: 15),
            if (onCancel != null || onAccept != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (strCancel != null)
                    GestureDetector(
                      onTap: onCancel ?? () => Navigator.of(context).pop(),
                      child: Container(
                        width: width,
                        height: height,
                        padding: const EdgeInsets.all(1.0),
                        decoration: decoration,
                        child: Center(
                          child: Text(
                            strCancel,
                            style: styleTextButton,
                          ),
                        ),
                      ),
                    ),
                  if (strCancel != null) const SizedBox(width: 20),
                  if (strAccept != null)
                    GestureDetector(
                      onTap: onAccept,
                      child: Container(
                        width: width,
                        height: height,
                        padding: padding,
                        margin: margin,
                        decoration: decoration,
                        child: Center(
                          child: Text(
                            strAccept,
                            style: styleTextButton,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // un dialogo para hijos de widgets pero manteniendo el estilo de los demás
  showDialogChildWidget({
    required Widget child,
    bool marginBottom = true,
    bool isScrollControlled = false,
  }) =>
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: isScrollControlled,
        builder: (context) => Container(
          padding: isScrollControlled
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom)
              : null,
          decoration: _decoration(),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  // list
                  child,
                  if (marginBottom) const SizedBox(height: 20),
                ],
              ),
              /* Positioned(
                left: 0,
                right: 0,
                child: Container(
                  decoration: _decoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 40,
                        margin: const EdgeInsets.only(top: 12.5, bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ), */
              // title
              if (title != null)
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // title
                    if (title != null) Text(title!),
                    // divisor
                    if (title != null)
                      Container(
                        width: MediaQuery.of(context).size.width * 0.52,
                        height: 4,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(99999),
                        ),
                      ),
                  ]),
                  /*    child: Container(
                    padding:
                        const EdgeInsets.only(top: 30, bottom: 15, left: 40),
                    margin: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(title!),
                  ), */
                ),
            ],
          ),
        ),
      );

  // un dialogo para hijos de widgets pero manteniendo el estilo de los demás
  showDialogScrolledWidget({
    required Widget child,
    double minHeight = 0.25,
    double initialChildSize = 0.5,
    double maxHeight = 1.0,
    bool? enabledSize,
    TextAlign textAlignTitle = TextAlign.start,
    TextStyle? stylesTitle,
    bool expand = true,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => enabledSize != null
          ? makeDismissible(
              child: DraggableScrollableSheet(
                initialChildSize: initialChildSize,
                maxChildSize: maxHeight,
                minChildSize: minHeight,
                expand: expand,
                builder: (_, c) => children(child, controller: c),
              ),
            )
          : children(child,
              stylesTitle: stylesTitle, textAlignTitle: textAlignTitle),
    );
  }

  Widget children(Widget child,
          {ScrollController? controller,
          TextStyle? stylesTitle,
          TextAlign textAlignTitle = TextAlign.start}) =>
      Container(
        decoration: _decoration(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          controller: controller,
          shrinkWrap: true,
          children: [
            const SizedBox(height: 25),
            // title
            if (title != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionsLeading != null) actionsLeading!,
                  Expanded(
                    child: Center(
                      child: Text(title!),
                    ),
                  ),
                  if (actionsTrailing != null) actionsTrailing!,
                ],
              ),
            // divisor
            if (title != null)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.52,
                    height: 4,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(99999),
                    ),
                  ),
                ],
              ),

            /*   Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Text(
                    title!,
                    textAlign: textAlignTitle,
                    style: stylesTitle,
                  ),
                ],
              ), */
            const SizedBox(height: 10),
            // message
            if (textContent != null)
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      textContent!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            // children
            child,
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );

  static Widget item(
    IconData? icon,
    String title, {
    Color? colorIcon,
    bool hasSizedBoxUp = true,
    bool hasSizedBoxDown = true,
  }) {
    return Column(
      children: [
        if (hasSizedBoxUp) const SizedBox(height: 20),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Icon(
                icon,
                color: colorIcon,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        if (hasSizedBoxDown) const SizedBox(height: 20),
      ],
    );
  }

  void showPopUpDeleteList({
    String title = 'Borrar Lista',
    String content = '¿Estas seguro que deseas borrar esta lista?',
    TextStyle? styleTitle,
    String txtBtnAccept = "Aceptar",
    String txtBtnCancel = "Cancelar",
    void Function()? onConfirm,
  }) {
    AlertDialog alert = AlertDialog(
      title: Text(title, style: styleTitle),
      content: Text(content),
      actions: [
        TextButton(
          style: TextButton.styleFrom(foregroundColor: black),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(txtBtnCancel, style: styles),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(txtBtnAccept),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> showPopUp({
    String? titleTxt,
    Widget? content,
    TextStyle? styleTitle,
    TextAlign textAlignTitle = TextAlign.start,
    void Function()? onConfirm,
    bool barrierDismissible = true,
    bool showBtnCancel = true,
    bool showButtonActions = true,
    String? txtBtnCancel,
    String? txtBtnAccept,
    TextStyle? styleTxtBtnCancel,
    TextStyle? styleTxtBtnAccept,
  }) {
    AlertDialog alert = AlertDialog(
      title: titleTxt == null && title == null
          ? null
          : Text(
              title ?? titleTxt ?? '',
              style: styleTitle,
              textAlign: textAlignTitle,
            ),
      content: textContent != null ? Text(textContent!) : content,
      actions: showButtonActions
          ? [
              Visibility(
                visible: showBtnCancel,
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: black),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    txtBtnCancel ?? Tk.tCancel.tr,
                    style: styleTxtBtnCancel ?? styles,
                  ),
                ),
              ),
              Visibility(
                visible: onConfirm != null,
                child: TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    txtBtnAccept ?? Tk.tAccept.tr,
                    style: styleTxtBtnAccept,
                  ),
                ),
              ),
            ]
          : null,
    );

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // un dialogo customizable
  showCustomDialog(Widget child) => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: _decoration(),
          child: child,
        ),
      );

  // dialog image
  dialogImage(Widget image) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: InteractiveViewer(
            minScale: 0.1,
            maxScale: 10.0,
            child: image,
          ),
        ),
      );
}//.........
