import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:software_project/picker_map.dart';


import 'package:software_project/requestVerfication.dart';
import 'package:software_project/searchResultPage.dart';


Future<bool> _sendPlacetRequest(Map<String, dynamic> newPlace, List<File> images) async {
    
    
    String addPlace = jsonEncode(newPlace);
    
    
      http.Response responsePost = await http.post(
        Uri.parse("https://paveltrty.pythonanywhere.com/api/place/"),
        headers: {'Content-Type': 'application/json'},
        body: addPlace,
      );

      if (responsePost.statusCode == 200 || responsePost.statusCode == 201) {
        final entry = jsonDecode(responsePost.body);
        int place_id = entry['id'];
        int user_id = 92;
        String name = entry['Name'];
        for(File image in images){
          await Upload(imageFile: image, place: name, place_id: place_id, user_id: user_id);
        }

        return true;
      } else {
        //print('Request failed with status code ${responsePost.statusCode}');
        return false;
      }
    
  }

class AddNewLocationPage extends StatefulWidget {
  createState() => AddNewLocationPageState();
}

class AddNewLocationPageState extends State<AddNewLocationPage> {
  String location='';
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  ImagePicker picker = ImagePicker();
  List<File> selectedImages=[];
  double user_rate = 0;
  List<int> activatedTagsID = [];
  List<bool> _selectedTags = List.generate(7, (_) => false);
  List<String> tags = [
    'Historical Landmark',
    'Parks and Natural Attractions',
    'Cultural Festivals and Events',
    'Sports and Entertainment Venues',
    'Museums and Galleries',
    'Cultural and Architectural',
    'Street art'
  ];
  static int number_of_fount_entries = 0;

  
Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
      maxHeight: 1000, // To set maxheight of images that you want in your app
      maxWidth: 1000); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;
 
         // if atleast 1 images is selected it will add
        // all images in selectedImages
        // variable so that we can easily show them in UI
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
           setState(
      () {  },
    );
        } else {
          // If no image is selected it will show a
          // snackbar saying nothing is selected
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
     
  }
  String getTags(List<String> tags, List<bool> selected){
    List<String> result=[];
    for(int i = 0; i < tags.length; ++i){
      if(selected[i]){
      result.add(tags[i].toLowerCase());
      }
    }
    return result.join(', ');
  }
  build(context) {
    return SafeArea(
      
        child: Scaffold(
            
            backgroundColor: Color(0xFFEBF4FA),
            appBar: getAppBar(text:'New Place', context: context),
            body: SingleChildScrollView(child: Center(child: SizedBox(width: 350, /*height: 960,*/ child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(alignment: Alignment.topLeft,child:
                Container(height: 30, width: 150, child: Text(
                          'Place name',
                          style: const TextStyle(
                              
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF3797D0)),
                        ))),
                        Align(alignment: Alignment.topLeft,child:
               Container(
                          width: 330,
                          height: 60,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 14,
                                  color: Color(0xFFD9D9D9)),
                              hintText: 'type its name',
                              filled: false,
                              fillColor: Colors.transparent,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ))),),
                
                Align(alignment: Alignment.topLeft,child:
                
                Container(height: 30, width: 100, child: Text(
                          'Where’s it',
                          style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF3797D0)),
                        ))),
                
                Align(alignment: Alignment.topLeft,child:
                InkWell(child: 
                Container(
                  
                          width: 80,
                          height: 60,
                          child: Icon(location.isEmpty? Icons.add: Icons.delete), decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(25))),), onTap: ()async{
                              
                                if(location.isEmpty){
                                  location =await Navigator.push(context, MaterialPageRoute(builder: (context)=>PickerScreen()));
                                  setState(() {
                                    
                                  });
                                  
                                   
                                }else{
                                  setState(() {
                                    location = '';
                                  });
                                  
                                }
                            },),),
                
                Container(
                  
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
                                      tags[index], _selectedTags[index])),
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
              Align(
                        alignment: Alignment.topLeft,
                        child:  
                Container(height: 30, width: 100, child: Text(
                          'Your mark',
                          style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF3797D0)),
                        ))),
            //-----------------------------
            Align(
                        alignment: Alignment.topLeft,
                        child: ToggleButtons(
                              highlightColor: Colors.transparent,
                              selectedColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              fillColor: Colors.transparent,
                              constraints: BoxConstraints.tightFor(height: 35),
                              direction: Axis.horizontal,
                              renderBorder: false,
                              children: List.generate(
                                  5,
                                  (index) => Icon(user_rate-1 >= index? Icons.star : Icons.star_border, color:  Color.fromARGB(255, 247, 230, 78), weight: 1, size: 40, )),
                              isSelected: List.generate(
                                  5,
                                  (index) => user_rate >= index),
                              onPressed: (int index) {
                                setState(() {
                                  user_rate = index.toDouble()+1;
                                });
                              },
                            )),
                             Align(alignment: Alignment.topLeft,child:
                
                Container(height: 30, width: 150, child: Text(
                          'Description',
                          style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF3797D0)),
                        ))),
                
                Align(alignment: Alignment.topLeft,child:
                Container(
                          width: 330,
                          height: 140,
                          child: TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 14,
                                  color: Color(0xFFD9D9D9)),
                              hintText: 'share your experience',
                              filled: false,
                              fillColor: Colors.transparent,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ))),),
                          Align(alignment: Alignment.topLeft,child:
                
                Container(height: 30, width: 150, child: Text(
                          'Materials',
                          style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF3797D0)),
                        ))),
                        ElevatedButton(
               style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  // TO change button color
                  child: const Text('Select Image'),
                  onPressed: () {
                   getImages();
                  },
                ),
                  
          SizedBox(
                   width: 310.0, // To show images in particular area only
                   child: selectedImages.isEmpty  // If no images is selected
                       ? const Center(child: Text(''))//add something useful
                       // If atleast 1 images is selected
                       : Column(children: [GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                           itemCount: selectedImages.length,
                           gridDelegate:
                               const SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 3
                               // Horizontally only 3 images will show
                               ),
                           itemBuilder: (BuildContext context, int index) {
                             // TO show selected file
                             return Center(
                                 child: Container(height: 100, width: 100, child: Image.file(selectedImages[index], fit: BoxFit.cover)));
                             // If you are making the web app then you have to
                             // use image provider as network image or in
                             // android or iOS it will as file only
                           },
                         )]),
                 ),
               
                        
                SizedBox(height: 100),
                

                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      String all_tags = getTags(tags, _selectedTags);
                      //var place = NewPLace(Description: descriptionController.text, rating: user_rate, Name: nameController.text, tags: all_tags, Owner: 0, Is_Approved: true, Price: 123);
                      Map<String, dynamic> place={
                        "Description": descriptionController.text,
                        "rating": user_rate,
                        "Name": nameController.text,
                        "Tags": all_tags,
                        "Owner": null,
                        "Location": location,
                        "Is_Approved": false,
                        "Price":0

                      };
                      if(descriptionController.text==''||user_rate==0||nameController.text==''||all_tags==''||selectedImages.isEmpty){
                         ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Fill all the fields')));
                      }else {
                          if(await _sendPlacetRequest(place, selectedImages)){
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Something went wrong. Retry or check Internet connection')));
                        
                      }
                      }
                      
                      

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
                          'Submit',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 21,
                              color: Color(0xFF212656)),
                        )),
                  ),
                )
              ],
            ))))));
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



main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  build(context){
    return MaterialApp(home: AddNewLocationPage());
  }
}


Upload({String place='new_place', required File imageFile, required int place_id, required int user_id}) async {    
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
      var length = await imageFile.length();

      var uri = Uri.parse('https://paveltrty.pythonanywhere.com/api/album/add');

     var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('Image', stream, length,
          filename: '${place}.jpg');
          //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      request.fields['Post'] = place_id.toString();
      request.fields['Owner'] = user_id.toString();
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }






  // Widget buildFutureBuilder() {
  //   return FutureBuilder<List<NewPLace>>(
  //     future: getPosts(),
  //     builder: (context, snapshot) {
  //       // Error
  //       if (snapshot.hasError) {
  //         return Text(
  //           "Error",
  //           style: TextStyle(fontSize: 50),
  //         );
  //       }
  //       // Done
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         List<NewPLace> posts = snapshot.data as List<NewPLace>;
  //         return buildPostList(posts);
  //       }
  //       // Loading
  //       return buildLoadingView();
  //     },
  //   );
  // }