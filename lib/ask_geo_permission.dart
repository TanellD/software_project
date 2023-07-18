import 'package:flutter/material.dart';
import 'package:software_project/person_account.dart';

class AskPermission extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _askPermissionState();
  }
}

class _askPermissionState extends State<AskPermission>{
  build(context){
    return SafeArea(child: Scaffold(backgroundColor: Color(0xFFF9F9F9),
    body: Center(child: Column(children: [
      Text('For better experience share your geolocation'),
      ElevatedButton(onPressed: ()=>(), child: Container(child: Text('Share'), decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(35))),)),
      SizedBox(height: 200,),
      ElevatedButton(onPressed: ()=>(), child: Text('Skip for now'))
    ],)),
    ));
  }
}

main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  build(context){
    return MaterialApp(home: AskPermission());
  }
}