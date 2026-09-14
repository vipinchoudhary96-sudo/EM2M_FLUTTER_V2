import 'package:flutter/material.dart';
class NumericInput extends StatelessWidget {
  final TextEditingController controller; final String label;
  const NumericInput({super.key,required this.controller,required this.label});
  @override Widget build(BuildContext c)=>TextField(
    controller:controller,
    keyboardType:const TextInputType.numberWithOptions(decimal:true),
    decoration:InputDecoration(labelText:label),
  );
}
