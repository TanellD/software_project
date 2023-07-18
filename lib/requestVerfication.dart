import 'package:flutter/material.dart';

class RequestVerification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RequestVerificationState();
}

class RequestVerificationState extends State<RequestVerification> {
  build(context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFEBF4FA),
        appBar: getAppBar(text:'Request Verification'),
        body: Column(children: [
          const SizedBox(
            height: 15,
            width: 390,
          ),
          Center(
              child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(13)),
              color: Color(0xFFF9F9F9),
            ),
            width: 360,
            height: 330,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 380,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: 100, height: 100, child: AddMaterial()),
                          SizedBox(
                              width: 100, height: 100, child: AddMaterial()),
                          SizedBox(
                              width: 100, height: 100, child: AddMaterial()),
                        ],
                      )),
                  SizedBox(
                      width: 380,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: 100, height: 100, child: AddMaterial()),
                          SizedBox(
                              width: 100, height: 100, child: AddMaterial()),
                          SizedBox(
                              width: 100, height: 100, child: AddMaterial()),
                        ],
                      )),
                  const Text(
                    'Upload up to six photos',
                    style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 17,
                        color: Color(0xFFD9D9D9)),
                  )
                ]),
          )),
          Center(
            child: SizedBox(
                width: 330,
                height: 360,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 330,
                          height: 60,
                          child: FieldForText(title: 'Full Name')),
                      Container(
                          width: 330,
                          height: 60,
                          child: FieldForText(title: 'Date of Birth')),
                      Container(
                          width: 330,
                          height: 60,
                          child: FieldForText(title: 'Nationality')),
                      Container(
                          width: 330,
                          height: 60,
                          child: FieldForText(
                              title: 'Address / IP address : ')),
                      Container(
                          width: 330,
                          height: 60,
                          child: Row(children: [
                             SizedBox(
                              width: 250,
                              height: 60,
                              child: FieldForText(
                                  title: 'Identification Document'),
                            ),
                            SizedBox(
                              width: 70,
                              height: 40,
                              child: AddMaterial(),
                            )
                          ])),
                    ])),
          ),
          TextButton(
            onPressed: () => (),
            child: const Text(
              'submit',
              style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 17,
                  color: Color(0xFF555555)),
            ),
          )
        ]),
      ),
    );
  }
}




class AddMaterial extends StatelessWidget {
  build(context) {
    return InkWell(
      child: Container(
        child: SizedBox(child: Align(child: Icon(Icons.add, size: 30,))),
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.grey)],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFFD9D9D9),),
      ),
      onTap: () => (),
      
    );
  }
}




AppBar getAppBar({required String text, context, var result}){
  return AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        title: Text(
          text,
          style: const TextStyle(
            color:  Color(0xFF212656),
            fontFamily: 'Source Sans Pro',
            fontSize: 27,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          
          iconSize: 25,
          color: const Color(0xFF212656),
          onPressed: (){
            Navigator.pop(context, result);
          },
        ),
      );
}

// class TopBar extends AppBar{
//   String text='';
//   TopBar({super.key, required this.text});
//   build(context){
//     return AppBar(
//         backgroundColor: const Color(0xFFF9F9F9),
//         elevation: 0,
//         title: Text(
//           text,
//           style: const TextStyle(
//             color:  Color(0xFF212656),
//             fontFamily: 'Source Sans Pro',
//             fontSize: 27,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
          
//           iconSize: 25,
//           color: const Color(0xFF212656),
//           onPressed: (){
//             Navigator.pop(context);
//           },
//         ),
//       );
//   }
// }




class FieldForText extends StatefulWidget {
  
   int max_lines = 1;
    double circularRadius;
  FieldForText({Key? key, required this.title, this.circularRadius=25});
  final String title;
  

  @override
  State<FieldForText> createState() =>_FieldForTextState(text:title, circle: circularRadius);
}

class _FieldForTextState extends State<FieldForText> {
  String title = '';
  int max_lines = 1;
  double circularRadius=25;
  _FieldForTextState({Key? key, String text='', double circle=25, int lines=1}) {
    title = text;
    circularRadius = circle;
    max_lines = lines;
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
                decoration: BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(circularRadius))),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        child: TextField(
                          expands: true,
                          maxLines: null,
                          minLines: null,
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
