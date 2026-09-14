import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});
  @override State<PasswordScreen> createState()=>_PasswordScreenState();
}
class _PasswordScreenState extends State<PasswordScreen>{
  final a=TextEditingController(),b=TextEditingController();
  Future<void> save()async{
    if(a.text.length<4||a.text!=b.text){ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content:Text('Minimum 4 characters and both fields must match')));return;}
    await StorageService().setPassword(a.text);if(mounted)Navigator.pop(context);
  }
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Password')),
    body:ListView(padding:const EdgeInsets.all(16),children:[
      TextField(controller:a,obscureText:true,decoration:const InputDecoration(labelText:'New password')),
      TextField(controller:b,obscureText:true,decoration:const InputDecoration(labelText:'Confirm password')),
      FilledButton(onPressed:save,child:const Text('SAVE')),
    ]));
}
