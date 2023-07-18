import 'package:flutter/material.dart';
import 'package:software_project/filter.dart';
import 'package:software_project/requestVerfication.dart';
import 'package:software_project/searchResultPage.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
List<String> constraints=['rating'];

  TextEditingController controller = TextEditingController();
  build(context) {
    return SafeArea(
        child: Scaffold(
      appBar: getAppBar(text:'Search', context: context),
      backgroundColor: Color(0xFFF9F9F9),
      body: Column(children: [
        SizedBox(
          height: 4,
        ),
        Center(
            child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 350,
          decoration: BoxDecoration(border: Border.all(),
            color: Color(0xFFF9F9F9),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.clear(),
                  
                ), hintText: 'Start typing', 
                border: InputBorder.none),
                
          ),
        )),
        Align(alignment: Alignment.topLeft, child: 
        ElevatedButton(
          style: ButtonStyle(elevation: MaterialStatePropertyAll(0), backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent)),
          onPressed: 
        ()async{
          FocusManager.instance.primaryFocus?.unfocus();
          constraints = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Filters(given_result: constraints)));
        }
        , child: Container(

          
          height: 30,
          width: 100,
          decoration: BoxDecoration(border: Border.all(),
            color: Color(0xFFF9F9F9),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Center(child: Text('Choose Filters', style: TextStyle(color: Colors.black),), ))))
      ]),
      floatingActionButton: Align(alignment: Alignment.bottomCenter, child: ElevatedButton(
          style: ButtonStyle(elevation: MaterialStatePropertyAll(0), backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent)),
          onPressed: 
        (){
          int sortId = 0;
          if(constraints[0]=='rating'){
            sortId = 0;
          } else if(constraints[0]=='reviews'){
            sortId = 1;
          } else {
            sortId = 2;
          }
          List<String> resList=[];
          for(int i = 1; i < constraints.length; ++i){
            resList.add(constraints[i]);
          }
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResultsPage(headerMessage: 'Search Results', query: controller.text, tags: resList, sortId: sortId,)));}
        , child: Container(

          
          height: 40,
          width: 150,
          decoration: BoxDecoration(border: Border.all(),
            color: Color(0xFFF9F9F9),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Center(child: Text('Search', style: TextStyle(color: Colors.black, fontSize: 21),), ))),
    )));
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}
