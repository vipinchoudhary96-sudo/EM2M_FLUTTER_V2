import 'package:flutter/material.dart';

class InverterControl extends StatelessWidget {
  final String actual;
  final String requested;
  final bool confirmed;
  final bool busy;
  final Future<void> Function(String) onCommand;
  const InverterControl({super.key,required this.actual,required this.requested,
    required this.confirmed,required this.busy,required this.onCommand});

  @override Widget build(BuildContext c) => Card(child:Padding(
    padding:const EdgeInsets.all(12),
    child:Column(children:[
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
        const Text('INVERTER',style:TextStyle(fontWeight:FontWeight.bold)),
        Text('$actual  ${confirmed?"✓ CONFIRMED":"WAITING"}'),
      ]),
      if(requested!='--') Align(alignment:Alignment.centerLeft,child:Text('Requested: $requested')),
      const SizedBox(height:10),
      Row(children:[
        Expanded(child:FilledButton(onPressed:busy?null:()=>onCommand('ON'),child:const Text('ON'))),
        const SizedBox(width:10),
        Expanded(child:OutlinedButton(onPressed:busy?null:()=>onCommand('OFF'),child:const Text('OFF'))),
      ]),
    ]),
  ));
}
