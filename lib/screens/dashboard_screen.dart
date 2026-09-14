import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../utils/constants.dart';
import '../widgets/connection_status.dart';
import '../widgets/inverter_control.dart';
import '../widgets/battery_status.dart';
import '../widgets/sd_status.dart';
import '../widgets/meter_card.dart';
import 'settings_screen.dart';
import 'connection_screen.dart';
import 'reports_screen.dart';
import 'events_screen.dart';
import 'password_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override Widget build(BuildContext c) {
    final s = c.watch<AppState>();
    final d = s.meter;
    return Scaffold(
      appBar: AppBar(
        title: const Text('EM2M Controller V2'),
        actions: [
          Padding(padding:const EdgeInsets.symmetric(horizontal:12),
            child:Center(child:ConnectionStatus(connected:s.online))),
          PopupMenuButton<String>(
            onSelected:(v){
              if(v=='settings')Navigator.push(c,MaterialPageRoute(builder:(_)=>const SettingsScreen()));
              if(v=='connections')Navigator.push(c,MaterialPageRoute(builder:(_)=>const ConnectionScreen()));
              if(v=='reports')Navigator.push(c,MaterialPageRoute(builder:(_)=>const ReportsScreen()));
              if(v=='events')Navigator.push(c,MaterialPageRoute(builder:(_)=>const EventsScreen()));
              if(v=='password')Navigator.push(c,MaterialPageRoute(builder:(_)=>const PasswordScreen()));
            },
            itemBuilder:(_)=>const[
              PopupMenuItem(value:'settings',child:Text('Settings')),
              PopupMenuItem(value:'connections',child:Text('Connections')),
              PopupMenuItem(value:'reports',child:Text('Reports')),
              PopupMenuItem(value:'events',child:Text('Events / Faults')),
              PopupMenuItem(value:'password',child:Text('Password')),
            ],
          )
        ],
      ),
      body:RefreshIndicator(
        onRefresh:()async{await s.loadSettings();},
        child:ListView(padding:const EdgeInsets.all(12),children:[
          if(s.message.isNotEmpty)Card(child:ListTile(
            leading:const Icon(Icons.info_outline),title:Text(s.message))),
          if(d==null)const Card(child:ListTile(
            leading:Icon(Icons.cloud_off),title:Text('Waiting for ESP32...'),
            subtitle:Text('The ESP32 control system must operate independently.'),
          )),
          if(d!=null)...[
            InverterControl(actual:d.inverterActual,requested:d.inverterRequested,
              confirmed:d.feedbackConfirmed,busy:s.commandBusy,
              onCommand:s.inverter),
            BatteryStatus(voltage:d.batteryVoltage,valid:d.batteryValid),
            SdStatus(available:d.sdAvailable),
            ...List.generate(d.values.length,(i)=>MeterCard(
              name:i<meterNames.length?meterNames[i]:'Parameter $i',
              unit:i<meterUnits.length?meterUnits[i]:'',
              value:d.values[i],
            )),
          ],
        ]),
      ),
    );
  }
}
