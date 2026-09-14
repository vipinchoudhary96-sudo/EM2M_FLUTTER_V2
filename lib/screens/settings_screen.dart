import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/app_settings.dart';
import '../utils/validators.dart';
import '../widgets/numeric_input.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override State<SettingsScreen> createState()=>_SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{
  final onV=TextEditingController(text:'48.000');
  final hyst=TextEditingController(text:'1.5');
  final onD=TextEditingController(text:'5000');
  final offD=TextEditingController(text:'5000');
  final fb=TextEditingController(text:'5000');
  bool autoMode=true,requireFeedback=true,remote=true;
  String msg='';

  @override void initState(){super.initState();WidgetsBinding.instance.addPostFrameCallback((_){
    final s=context.read<AppState>().settings;
    if(s!=null)setState(()=>apply(s));
  });}

  void apply(AppSettings s){
    onV.text=s.onVoltage.toStringAsFixed(3);
    hyst.text=s.hysteresis.toStringAsFixed(1);
    onD.text='${s.onDelayMs}';offD.text='${s.offDelayMs}';fb.text='${s.feedbackTimeoutMs}';
    autoMode=s.autoMode;requireFeedback=s.requireFeedback;remote=s.allowRemoteControl;
  }

  Future<void> save()async{
    final v=double.tryParse(onV.text),h=double.tryParse(hyst.text);
    final od=int.tryParse(onD.text),ofd=int.tryParse(offD.text),ft=int.tryParse(fb.text);
    if(v==null||!validBatteryVoltage(v)||h==null||!validHysteresis(h)||od==null||ofd==null||ft==null){
      setState(()=>msg='Invalid range');return;
    }
    final s=AppSettings(onVoltage:v,hysteresis:h,onDelayMs:od,offDelayMs:ofd,
      autoMode:autoMode,feedbackTimeoutMs:ft,requireFeedback:requireFeedback,
      allowRemoteControl:remote);
    try{
      final saved=await context.read<AppState>().api.saveSettings(s);
      context.read<AppState>().settings=saved;
      setState(()=>msg='Saved and verified by ESP32 read-back');
    }catch(e){setState(()=>msg='Save failed: $e');}
  }

  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Settings')),
    body:ListView(padding:const EdgeInsets.all(16),children:[
      NumericInput(controller:onV,label:'ON voltage 10.000–60.000 V'),
      NumericInput(controller:hyst,label:'Hysteresis 0.0–3.0 V'),
      NumericInput(controller:onD,label:'ON delay (ms)'),
      NumericInput(controller:offD,label:'OFF delay (ms)'),
      NumericInput(controller:fb,label:'Feedback timeout (ms)'),
      SwitchListTile(value:autoMode,onChanged:(v)=>setState(()=>autoMode=v),
        title:const Text('Automatic mode')),
      SwitchListTile(value:requireFeedback,onChanged:(v)=>setState(()=>requireFeedback=v),
        title:const Text('Require feedback confirmation')),
      SwitchListTile(value:remote,onChanged:(v)=>setState(()=>remote=v),
        title:const Text('Allow remote commands')),
      const SizedBox(height:10),
      FilledButton(onPressed:save,child:const Text('SAVE')),
      if(msg.isNotEmpty)Padding(padding:const EdgeInsets.all(12),child:Text(msg)),
      const Text('Numeric fields support cursor placement and individual digit editing.'),
    ]));
}
