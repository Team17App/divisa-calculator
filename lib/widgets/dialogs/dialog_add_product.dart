// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../api-services/api_services.dart';
import '../../widgets/widgets.dart';
import '../../models.dart/models.dart';
import '../../utilities/utilities.dart';

class DialogAddProduct extends StatefulWidget {
  final ProductModel? product;
  const DialogAddProduct({this.product, super.key});

  @override
  State<DialogAddProduct> createState() => _DialogAddProductState();
}

class _DialogAddProductState extends State<DialogAddProduct> {
  final AllController allctr = Get.find();
  final ctrName = TextEditingController(text: '?');
  final ctrPrice = TextEditingController(text: '0.0');
  final ctrQuantity = TextEditingController(text: '1');

  int type = -1;
  late ProductModel product;
  late final bool newPm;

  @override
  void initState() {
    newPm = widget.product == null;
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    product = widget.product ?? ProductModel(id: id);
    if (!newPm) {
      ctrName.text = product.name;
      ctrPrice.text = product.price.toStringAsFixed(2);
      ctrQuantity.text = product.quantity.toString();
      type = product.type;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return AnimatedContainer(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
        color: grey800,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            Tk.kAddProduct.tr,
            style: stylesTitles.copyWith(color: white),
          ),
          const SizedBox(height: 20),
          EditTextWidget(
            controller: ctrName,
            textInputType: TextInputType.name,
            hintText: Tk.kName.tr,
            textAlign: TextAlign.center,
            textStyle: styleLight.copyWith(color: white),
            maxLength: 20,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: EditTextWidget(
                  controller: ctrQuantity,
                  textInputType: const TextInputType.numberWithOptions(),
                  hintText: Tk.kQuantity.tr,
                  textAlign: TextAlign.center,
                  textStyle: styleLight.copyWith(color: white),
                  maxLength: 3,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: EditTextWidget(
                  controller: ctrPrice,
                  autoFocus: true,
                  textInputType: TextInputType.number,
                  hintText: Tk.kPrice.tr,
                  textAlign: TextAlign.center,
                  textStyle: styleLight.copyWith(color: white),
                  maxLength: 100,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              button(
                onPressed: () => setState(() => type = 0),
                select: type == 0,
                text: '\$',
              ),
              button(
                onPressed: () => setState(() => type = 1),
                select: type == 1,
                text: 'COP',
              ),
              button(
                onPressed: () => setState(() => type = 2),
                select: type == 2,
                text: 'Bs',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            allctr.numberFormat(
                ctrPrice.text.toDouble * ctrQuantity.text.toInteger),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: createItemProduct,
            child: Text(
              Tk.kAdd.tr,
              style: stylesTitles.copyWith(color: white),
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  void createItemProduct() async {
    if (type == -1) {
      Utils.toast('TYPE');
      return;
    }
    setState(() {});

    await Future.delayed(const Duration(milliseconds: 500));

    final price = ctrPrice.text.trim();
    final quantity = ctrQuantity.text.trim();
    final epoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (newPm) product = product.copyWith(id: epoch);

    product = product.copyWith(
      name: ctrName.text.trim(),
      price: double.parse(price.isEmpty ? '0.0' : price),
      quantity: int.parse(quantity.isEmpty ? '1' : quantity),
      type: type,
    );

    if (!newPm) {
      allctr.listProducts.value.removeWhere((item) => item.id == product.id);

      Utils.toast('R');
    }

    allctr.listProducts.add(product);
    allctr.calculateTotal();
    setState(() {});
    Get.back();
  }

  Widget button({
    required void Function()? onPressed,
    required String text,
    bool select = false,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: stylesTitles.copyWith(
          fontWeight: select ? null : FontWeight.w300,
          color: select ? green : Colors.greenAccent,
        ),
      ),
    );
  }
}
