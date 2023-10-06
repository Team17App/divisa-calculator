// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../../api-services/api_services.dart';
import '../../config/config.dart';
import '../../models.dart/models.dart';
import '../widgets.dart';
import '../../utilities/utilities.dart';

class ItemHomeWidget extends StatefulWidget {
  final ProductModel model;
  final void Function(ProductModel) onDeleted;
  const ItemHomeWidget(
      {required this.model, required this.onDeleted, super.key});

  @override
  State<ItemHomeWidget> createState() => _ItemHomeWidgetState();
}

class _ItemHomeWidgetState extends State<ItemHomeWidget> {
  final AllController allctr = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final sym = getSymbol(model.type);
    return ListTile(
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(model.name),
            Text(
              ' ${model.quantity}x ${allctr.numberFormat(model.price, sym: sym)}',
              style: stylesMin.copyWith(color: grey),
            ),
          ]),
      leading: IconButton(
        onPressed: () => widget.onDeleted(model),
        icon: const Icon(Icons.cancel),
      ),
      trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              allctr.numberFormat(model.subTotal, sym: sym),
            ),
            Visibility(
              visible: model.type != 0,
              child: Text(
                getValueUSD(model),
                style: stylesMin.copyWith(color: grey),
              ),
            ),
          ]),
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          barrierColor: transparent,
          backgroundColor: transparent,
          isScrollControlled: true,
          builder: (context) {
            return DialogAddProduct(product: widget.model);
          },
        );
      },
    );
  }

  funOnChanged(String value) {
    final text = value.isEmpty ? '0.0' : value;
    final price = double.parse(text);
    for (var i = 0; i < allctr.listProducts.value.length; i++) {
      if (widget.model.id == allctr.listProducts[i].id) {
        allctr.listProducts.value[i].price = price;
      }
    }
    allctr.calculateTotal();
    setState(() {});
  }

  String getSymbol(int type) {
    if (type == 0) {
      return '\$';
    } else if (type == 1) {
      return 'COP';
    } else if (type == 2) {
      return 'Bs';
    } else {
      return '\$';
    }
  }

  String getValueUSD(ProductModel model) {
    String value = '0';
    if (model.type == 1) {
      value = allctr.numberFormat(model.refToDollar(allctr.ref2.value));
    }
    if (model.type == 2) {
      value = allctr.numberFormat(model.refToDollar(allctr.ref1.value));
    }
    return value;
  }
}
