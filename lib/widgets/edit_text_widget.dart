import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/utilities.dart';

get onValidatorDefault =>
    (value) => (value?.isEmpty ?? true) ? 'Campo es requerido' : null;

class EditTextWidget extends StatefulWidget {
  final Color? colorBackground;
  final Color? colorBorder;
  final InputBorder? border;
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? suffixIconConstraints;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final bool? enabled;
  final bool titleIsHint;
  final TextAlign textAlign;
  final bool obscureText;
  final String? Function(String?)? onValidator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool autoCorrect;

  const EditTextWidget(
      {this.controller,
      this.hintText = '',
      this.title = '',
      this.prefixIcon,
      this.suffixIcon,
      this.maxLength,
      this.maxLines = 1,
      this.minLines = 1,
      this.textInputType,
      this.textInputAction,
      this.colorBackground,
      this.colorBorder,
      this.border,
      this.onChanged,
      this.onSaved,
      this.contentPadding,
      this.hintStyle,
      this.titleStyle,
      this.textStyle,
      this.enabled,
      this.titleIsHint = true,
      this.suffixIconConstraints,
      this.textAlign = TextAlign.start,
      this.obscureText = false,
      this.onValidator,
      this.inputFormatters,
      this.focusNode,
      this.autoFocus = false,
      this.autoCorrect = true,
      super.key});

  @override
  State<EditTextWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  int ep = -1;

  @override
  void initState() {
    ep = DateTime.now().millisecondsSinceEpoch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.titleIsHint || widget.title.isNotEmpty,
          child: Padding(
            padding: widget.contentPadding ??
                const EdgeInsets.only(right: 8, top: 8),
            child: Text(
              widget.titleIsHint ? widget.hintText : widget.title,
              style: widget.titleStyle ?? stylesTitlesCard,
            ),
          ),
        ),
        TextFormField(
          key: widget.key ?? ValueKey('key_$ep'),
          controller: widget.controller,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          enabled: widget.enabled,
          style: widget.textStyle,
          textAlign: widget.textAlign,
          obscureText: widget.obscureText,
          validator: widget.onValidator,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus,
          autocorrect: widget.autoCorrect,
          decoration: InputDecoration(
            hintText: widget.hintText,
            isDense: true,
            hintStyle: widget.hintStyle ?? styles.copyWith(color: Colors.grey),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 5.0),
            suffixIconConstraints: widget.suffixIconConstraints ??
                const BoxConstraints(maxHeight: 14),
            focusedBorder: widget.border,
            enabledBorder: widget.border,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ],
    );
  }
}
