import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:software_project/connection.dart';
import 'dart:io';

import 'package:software_project/requestVerfication.dart';
import 'package:software_project/searchResultPage.dart';
import 'package:http/http.dart' as http;

class AddNewReviewPage extends StatefulWidget {
  NewPLace album;
  AddNewReviewPage({required this.album});
  createState() => AddNewReviewPageState(album: album);
}

class AddNewReviewPageState extends State<AddNewReviewPage> {
  NewPLace album;
  AddNewReviewPageState({required this.album});
  ImagePicker picker = ImagePicker();
  List<File> selectedImages=[];
  int user_rate = 0;
  
  static int number_of_found_entries = 0;

  
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
  TextEditingController _searchController = TextEditingController();
  

  build(context) {
    
    return SafeArea(
      
        child: Scaffold(
          resizeToAvoidBottomInset : true,
            
            backgroundColor: Color(0xFFEBF4FA),
            appBar: getAppBar(text:'New Review', context: context),
            body: SingleChildScrollView(child: Center(child: Column(
              children: [
                Center(child: Container(width: double.infinity, color: Color(0xFFF9F9F9), child: Center(child: SizedBox(width: 350, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(album.Name, style: TextStyle(fontSize: 27),),
                  Row(children: [
                          Row(
                              children: List.generate(
                                  5,
                                  (index) => Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: Icon(
                                          album.rating.ceil() >=
                                                  index + 1
                                              ? Icons.star
                                              : Icons.star_border,
                                          color:Color.fromARGB(255, 247, 230, 78),
                                        ),
                                      ))),
                          // Padding(
                          //   padding: const EdgeInsets.all(0),
                          //   child: Text(
                          //       "${/*album.number_of_comments*/5} reviews",style: TextStyle(color: Colors.grey[600], fontSize: 14),),
                          // ),
                          
                        ]),
                        Text('${album.rating}',style: TextStyle(color: Colors.grey[600], fontSize: 21)),
                        SizedBox(height: 10,)
                        

                ],)))),),
                SizedBox(
                  height: 20,
                ),
                SizedBox(width: 350, child:
                Column(children: [
                
              Align(
                        alignment: Alignment.topLeft,
                        child:  
                Container(height: 30, width: 100, child: Text(
                          'Your mark',
                          style: TextStyle( fontSize: 21),
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
                                  (index) => Icon(user_rate >= index? Icons.star : Icons.star_border, color: Color.fromARGB(255, 247, 230, 78), weight: 1, size: 40, )),
                              isSelected: List.generate(
                                  5,
                                  (index) => user_rate >= index),
                              onPressed: (int index) {
                                setState(() {
                                  user_rate = index;
                                });
                              },
                            )),
                            SizedBox(height: 20,),
                             Align(alignment: Alignment.topLeft,child:
                
                Container(height: 30, width: 150, child: Text(
                          'Description',
                          style: TextStyle( fontSize: 21),
                        ))),
                
                Align(alignment: Alignment.topCenter,child:
                Container(
                          width: 360,
                          height: 140,
                          child: 
                          Padding(
            padding: EdgeInsets.symmetric(),
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(1))),
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
                              hintText: 'Write some information about the place',
                              filled: false,
                              fillColor: Colors.transparent,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ))))))
                          
                          ),),
                SizedBox(height: 20,),
          //                Align(alignment: Alignment.topLeft,child:
                
          //       Container(height: 30, width: 150, child: Text(
          //                 'Materials',
          //                 style: TextStyle( fontSize: 21),
          //               ))),
          //               Align(alignment: Alignment.centerLeft,child:
                        
          //               Row(
          //                 children: [
          //                   SizedBox(width: 10,),
          //                   ElevatedButton(
          //      style: ButtonStyle(
          //             backgroundColor: MaterialStateProperty.all(Colors.green)),
          //         // TO change button color
          //         child: const Text('Select Image'),
          //         onPressed: () {
          //          getImages();
          //         },
          //       ),
          //       selectedImages.isNotEmpty? ElevatedButton(
          //      style: ButtonStyle(
          //             backgroundColor: MaterialStateProperty.all(Colors.red)),
          //         // TO change button color
          //         child: const Text('Clear all'),
          //         onPressed: () {
          //           setState(() {
          //             selectedImages.clear();
          //           });
                   
          //         },
          //       ): Text(''),
          //                 ],
          //               )),
                  
          // SizedBox(
          //          width: 330.0, // To show images in particular area only
          //          child: selectedImages.isEmpty  // If no images is selected
          //              ? const Center(child: Column(
          //                children: [
          //                  Icon(Icons.add_photo_alternate, color: Color.fromRGBO(224, 224, 224, 1), size: 150, ),
          //                  Text('Add photos', style: TextStyle(color: Color.fromRGBO(224, 224, 224, 1), fontSize: 16))
          //                ],
          //              ))
          //              // If atleast 1 images is selected
          //              : Column(children: [GridView.builder(
          //               physics: NeverScrollableScrollPhysics(),
          //               shrinkWrap: true,
          //                  itemCount: selectedImages.length,
          //                  gridDelegate:
          //                      const SliverGridDelegateWithFixedCrossAxisCount(
          //                          crossAxisCount: 3
          //                      // Horizontally only 3 images will show
          //                      ),
          //                  itemBuilder: (BuildContext context, int index) {
          //                    // TO show selected file
          //                    return Center(
          //                        child: Container(height: 110, width: 110, child: Image.file(selectedImages[index], fit: BoxFit.cover)));
          //                    // If you are making the web app then you have to
          //                    // use image provider as network image or in
          //                    // android or iOS it will as file only
          //                  },
          //                )]),
          //        ),
               
                        
                selectedImages.isNotEmpty? SizedBox(height: 80): SizedBox(height: 30,),
                Align(
                  
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: ()async{
                      Map<String, dynamic> comment ={
                        'Description': _searchController.text,
                        'Post':album.place_id,////////////////////////////////
                        'Owner':92,
                        'rating':user_rate,
                        'date': DateTime.now().day.toString() + '/'+DateTime.now().month.toString() +'/' + DateTime.now().year.toString()

                      };
                      if(await _sendReview(comment)){
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ups, something went wrong')));
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
                ),

                
              ]
              )
              )
              ],
            ))),
            //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            
            )
            );
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


Future<bool> _sendReview(Map<String, dynamic> coment) async {
    
    
    String addReview = jsonEncode(coment);
    
    
      http.Response responsePost = await http.post(
        Uri.parse("https://paveltrty.pythonanywhere.com/api/comment/add"),
        headers: {'Content-Type': 'application/json'},
        body: addReview,
      );

      if (responsePost.statusCode == 200 || responsePost.statusCode == 201) {
        return true;
      } else {
        //print('Request failed with status code ${responsePost.statusCode}');
        return false;
      }
    
  }