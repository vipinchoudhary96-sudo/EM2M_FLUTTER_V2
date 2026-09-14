import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../export/report_exporter.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  @override State<ReportsScreen> createState()=>_ReportsScreenState();
}
class _ReportsScreenState extends State<ReportsScreen>{
  DateTime from=DateTime.now().subtract(const Duration(days:7)),to=DateTime.now();
  List<Map<String,dynamic>> rows=[];String msg='';

  Future<void> pick(bool first)async{
    final d=await showDatePicker(context:context,firstDate:DateTime(2020),
      lastDate:DateTime(2100),initialDate:first?from:to);
    if(d!=null)setState(()=>first?from=d:to=d);
  }
  Future<void> generate()async{
    try{rows=await context.read<AppState>().api.history(from,to);
      setState(()=>msg='${rows.length} records loaded');}
    catch(e){setState(()=>msg='History unavailable: $e');}
  }
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Consumption Reports')),
    body:ListView(padding:const EdgeInsets.all(16),children:[
      ListTile(title:const Text('From'),subtitle:Text(DateFormat('yyyy-MM-dd').format(from)),
        onTap:()=>pick(true)),
      ListTile(title:const Text('To'),subtitle:Text(DateFormat('yyyy-MM-dd').format(to)),
        onTap:()=>pick(false)),
      FilledButton(onPressed:generate,child:const Text('LOAD REPORT')),
      OutlinedButton(onPressed:rows.isEmpty?null:(){
        final csv=ReportExporter().toCsv(rows);
        setState(()=>msg='CSV prepared (${csv.length} bytes)');
      },child:const Text('PREPARE CSV')),
      Text(msg),
      if(rows.isNotEmpty)...rows.take(50).map((r)=>ListTile(title:Text('${r['timestamp']??''}'),
        subtitle:Text('Energy: ${r['energy_kwh']??'--'} kWh'))),
    ]));
}
