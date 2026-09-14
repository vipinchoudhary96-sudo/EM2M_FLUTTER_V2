import 'package:flutter/material.dart';
class SdStatus extends StatelessWidget {
  final bool available;
  const SdStatus({super.key,required this.available});
  @override Widget build(BuildContext c)=>ListTile(
    leading:Icon(Icons.sd_card,color:available?Colors.green:Colors.red),
    title:const Text('SD card'),
    subtitle:Text(available?'Available':'Not available'),
  );
}
