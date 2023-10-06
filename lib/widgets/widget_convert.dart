import 'package:divisa_calculator/widgets/edit_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import '../config/config.dart';

class WidgetConvertTo extends StatelessWidget {
  final List<TextEditingController> ctrs;
  final String tag;
  final void Function(double) onWrite;

  const WidgetConvertTo(
      {required this.ctrs, this.tag = 'TAG', required this.onWrite, super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      /* border: const TableBorder(
        horizontalInside:
            BorderSide(width: 1, color: grey, style: BorderStyle.solid),
      ), */
      children: [
        TableRow(children: [
          _itemRow(
            tag,
          ),
          _itemRow2(
            ctrs.first,
            onChanged: (p0) => onWrite(p0.toDouble),
          ),
          _itemRow2(
            ctrs.last,
            editable: false,
          ),
        ]),
      ],
      columnWidths: const {
        0: FractionColumnWidth(0.15),
        1: FractionColumnWidth(0.45),
        2: FractionColumnWidth(0.45),
      },
    );
  }

  Widget _itemRow(String text, [bool mark = false]) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(7).copyWith(top: 0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontWeight: mark ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  Widget _itemRow2(TextEditingController ctr,
      {bool? editable, void Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.all(7).copyWith(top: 0),
      child: EditTextWidget(
        controller: ctr,
        textAlign: TextAlign.center,
        textInputType: TextInputType.number,
        enabled: editable,
        onChanged: onChanged,
      ),
    );
  }
}
