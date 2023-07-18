import 'package:flutter/material.dart';
import 'package:software_project/requestVerfication.dart';

class Filters extends StatefulWidget {
  List given_result = [];
  Filters({required this.given_result});
  createState() => FiltersState(result: given_result);
}

class FiltersState extends State<Filters> {
  var result = [];
  int activeSortID = 0;
  List<int> activatedTagsID = [];
  List<bool> _selectedSort = [false, false];
  List<bool> _selectedTags = List.generate(7, (_) => false);
  Map<String, int> sorts = {
    'rating':0,
    'distance':1
  };
  Map<String, int> tags = {
    'historical landmark':0,
    'parks and natural attractions':1,
    'cultural festivals and events':2,
    'sports and entertainment venues':3,
    'museums and galleries':4,
    'cultural and architectural':5,
    'street art':6
  };
  List<String> all_tags = ['Historical Landmark',
    'Parks and Natural Attractions',
    'Cultural Festivals and Events',
    'Sports and Entertainment Venues',
    'Museums and Galleries',
    'Cultural and Architectural',
    'Street art'];
  FiltersState({required this.result}){
    activeSortID = sorts[result[0]]!;
    _selectedSort[sorts[result[0]]!] = true;
    for(int i = 1; i < result.length; ++i){
      _selectedTags[tags[result[i].toLowerCase()]!] = true;
    }

  }
  static int number_of_fount_entries = 0;
  build(context) {
    return SafeArea(
        child: Scaffold(
            
            backgroundColor: Color(0xFFEBF4FA),
            appBar: getAppBar(text: 'Select your filters', context: context, result: result),
      
            body: Column(
              children: [
                SizedBox(
                  width: 395,
                  height: 35,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '$number_of_fount_entries places found',
                          style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 17,
                              color: Color(0xFF3797D0)),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                activeSortID = 0;
                                activatedTagsID = [];
                                _selectedSort = [true, false];
                                _selectedTags = List.generate(7, (_) => false);
                              });
                            },
                            child: const Text(
                              'clear all',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 17,
                                  color: Color(0xFF3797D0)),
                            ))
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 220,
                  child: Column(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Sort by',
                          style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF3797D0)),
                        )),
                    Container(
                        width: 310,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ToggleButtons(
                              highlightColor: Colors.transparent,
                              selectedColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              fillColor: Colors.transparent,
                              constraints: BoxConstraints.tightFor(height: 35),
                              direction: Axis.vertical,
                              renderBorder: false,
                              children: [
                                PerfectButton('rating', _selectedSort[0]),
                                
                                PerfectButton('distance', _selectedSort[1])
                              ],
                              isSelected: _selectedSort,
                              onPressed: (int index) {
                                setState(() {
                                  _selectedSort[activeSortID] = false;
                                  _selectedSort[index] = true;
                                  activeSortID = index;
                                });
                              },
                            )
                          ],
                        ))
                  ]),
                ),
                Container(
                  width: 350,
                  height: 300,
                  child: Column(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Tags',
                          style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF3797D0)),
                        )),
                    Container(
                        width: 310,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ToggleButtons(
                              highlightColor: Colors.transparent,
                              selectedColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              fillColor: Colors.transparent,
                              constraints: BoxConstraints.tightFor(height: 35),
                              direction: Axis.vertical,
                              renderBorder: false,
                              children: List.generate(
                                  7,
                                  (index) => PerfectButton(
                                      all_tags[index], _selectedTags[index])),
                              isSelected: _selectedTags,
                              onPressed: (int index) {
                                setState(() {
                                  _selectedTags[index] = !_selectedTags[index];
                                });
                              },
                            )
                          ],
                        ))
                  ]),
                ),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: (){
                      result.clear();
            result.add(['rating', 'distance'][activeSortID]);
            for(int i = 0; i < _selectedTags.length; ++i){
              if(_selectedTags[i]){
                result.add(all_tags[i].toLowerCase());
              }
            }
            Navigator.pop(context, result);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFF3797D0), width: 1),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF212656)),
                        )),
                  ),
                )
              ],
            )));
  }
}

class PerfectButton extends Container {
  String text = '';
  bool selected = false;
  PerfectButton(String messg, bool selected) {
    text = messg;
    this.selected = selected;
  }
  build(context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(children: [
          Container(
              padding: EdgeInsets.symmetric(),
              alignment: Alignment.center,
              //width: text.length * 10,
              height: 30,
              decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFF9F9F9)
                      : const Color(0x65F9F9F9),
                  border: Border.all(
                      color: selected
                          ? const Color(0xFF3797D0)
                          : const Color(0x783798D0),
                      width: selected ? 1 : 0.5),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: Text(
                '  ' + text + '  ',
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 19,
                    color: selected ? Color(0xFF3797D0) : Color(0x783798D0)),
              ))
        ]));
  }
}
