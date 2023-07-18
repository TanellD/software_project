import 'package:flutter/material.dart';


class FieldForText extends StatefulWidget {
  const FieldForText({super.key, required this.title});
  final String title;
  // String getText(){
  //   this.getText();
  // }


  @override
  State<FieldForText> createState() =>_FieldForTextState(title);
}

class _FieldForTextState extends State<FieldForText> {
  String title = '';
  _FieldForTextState(String text) {
    title = text;
  }
  String getText(){
    return _searchController.text;
  }



  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: EdgeInsets.symmetric(),
            child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 14,
                                  color: Color(0xFFD9D9D9)),
                              hintText: title,
                              filled: false,
                              fillColor: Colors.transparent,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            )))))));
  }
}
