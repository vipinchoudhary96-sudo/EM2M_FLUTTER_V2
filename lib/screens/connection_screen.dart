import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../services/wifi_service.dart';
import '../services/web_server_service.dart';
import '../services/bluetooth_service.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});
  @override State<ConnectionScreen> createState()=>_ConnectionScreenState();
}
class _ConnectionScreenState extends State<ConnectionScreen>{
  final url=TextEditingController(text:'http://192.168.4.1');
  String msg=''; final ble=BluetoothService();

  Future<void> wifi()async{
    final api=context.read<AppState>().api;api.baseUrl=url.text.trim();
    final ok=await WifiService(api).test();setState(()=>msg=ok?'Wi-Fi connected':'Wi-Fi unavailable');
  }
  Future<void> web()async{
    final api=context.read<AppState>().api;api.baseUrl=url.text.trim();
    final ok=await WebServerService(api).test();setState(()=>msg=ok?'Web server reachable':'Web server unavailable');
  }
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Connections')),
    body:ListView(padding:const EdgeInsets.all(16),children:[
      const ListTile(leading:Icon(Icons.wifi),title:Text('Wi-Fi'),subtitle:Text('ESP32 AP/LAN')),
      TextField(controller:url,decoration:const InputDecoration(labelText:'ESP32 URL')),
      FilledButton(onPressed:wifi,child:const Text('TEST WI-FI')),
      const ListTile(leading:Icon(Icons.web),title:Text('Web server'),subtitle:Text('REST API')),
      OutlinedButton(onPressed:web,child:const Text('TEST WEB SERVER')),
      const ListTile(leading:Icon(Icons.bluetooth),title:Text('Bluetooth LE'),
        subtitle:Text('V2 GATT transport abstraction; final UUIDs must match firmware.')),
      OutlinedButton(onPressed:()async{
        try{await ble.connect();setState(()=>msg='BLE connected');}
        catch(e){setState(()=>msg='BLE not enabled until ESP32 GATT is frozen');}
      },child:const Text('CONNECT BLUETOOTH')),
      const Divider(),Text(msg),
      const Padding(padding:EdgeInsets.only(top:16),child:Text(
        'Connection loss must not stop ESP32 automatic interlock, relay control, '
        'meter polling or feedback monitoring.')),
    ]));
}
