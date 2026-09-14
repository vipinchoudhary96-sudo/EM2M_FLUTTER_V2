import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_state.dart';
import '../models/event_record.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Events / Faults')),
    body:FutureBuilder<List<EventRecord>>(
      future:c.read<AppState>().api.events(),
      builder:(c,s){
        if(s.connectionState==ConnectionState.waiting)return const Center(child:CircularProgressIndicator());
        if(s.hasError)return Center(child:Text('Events unavailable: ${s.error}'));
        final e=s.data??[];
        return ListView.builder(itemCount:e.length,itemBuilder:(c,i)=>ListTile(
          leading:Icon(e[i].severity=='fault'?Icons.error:Icons.info),
          title:Text(e[i].message),subtitle:Text('${e[i].type} • ${DateFormat('yyyy-MM-dd HH:mm:ss').format(e[i].time)}'),
        ));
      },
    ));
}
