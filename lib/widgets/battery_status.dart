import 'package:flutter/material.dart';
class BatteryStatus extends StatelessWidget {
  final double voltage; final bool valid;
  const BatteryStatus({super.key,required this.voltage,required this.valid});
  @override Widget build(BuildContext c)=>Card(child:ListTile(
    leading:const Icon(Icons.battery_charging_full),
    title:const Text('Battery voltage'),
    subtitle:Text('${voltage.toStringAsFixed(3)} V'),
    trailing:Text(valid?'VALID':'INVALID'),
  ));
}
