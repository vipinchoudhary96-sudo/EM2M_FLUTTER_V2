import 'package:flutter/material.dart';
class MeterCard extends StatelessWidget {
  final String name,unit; final double? value;
  const MeterCard({super.key,required this.name,required this.unit,required this.value});
  @override Widget build(BuildContext c)=>Card(child:ListTile(
    title:Text(name),subtitle:Text(unit),
    trailing:Text(value==null?'--':value!.toStringAsFixed(3)),
  ));
}
