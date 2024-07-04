import 'package:flutter/material.dart';


class QuantitySelector extends StatelessWidget {
  final IconData icon;
  final int quantity;
  final Function() onIncrement;
  final Function() onDecrement;
  const QuantitySelector({super.key,required this.icon , required this.quantity,
   required this.onIncrement , required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
