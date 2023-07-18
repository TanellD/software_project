import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:software_project/addNewLocationPage.dart';
import 'package:software_project/big_map.dart';
import 'package:software_project/connection.dart';
import 'package:software_project/main.dart';
import 'package:software_project/person_account.dart';
import 'package:software_project/searchResultPage.dart';
import 'package:software_project/settingPage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:software_project/sign_up_new.dart';
import 'package:http/http.dart' as http;

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  int _currentIndex = 0;
  late String? profileName = signedPerson.user_name;
  late String? profileEmail = signedPerson.user_email;
  bool confirmLogout = false;
  bool imageVisible = true;
  File? _image;
  int index_of_approving = 0;

  Future<void> _uploadProfilePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        imageVisible = false;
      });
    }
  }

  Text logOutMessage = Text(
    "Log Out",
    style: TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
  );

  @override
  Widget build(BuildContext context) {
    if (saveEmail != null) {
      signedPerson.user_email = saveEmail.toString();
      profileEmail = signedPerson.user_email;
      signedPerson.user_name = profileEmail
          .toString()
          .substring(0, signedPerson.user_email?.indexOf('@'));

      profileName = signedPerson.user_name;
    }
    return Scaffold(
      backgroundColor: Color(0xFF3797D0),
      appBar: AppBar(
        backgroundColor: Color(0xFF3797D0),
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios), // Change the icon to your desired icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Back",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            SizedBox(
              width: 180,
            ),
            InkWell(
              onTap: () async {
                if (!confirmLogout) {
                  // Change to "Confirm" and wait for a delay
                  confirmLogout = true;
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {                
                  });
                  
                } else {
                  setState(() {
                    if (confirmLogout) {
                      // Log out
                      confirmLogout = false;
                      removeUserToken();
                      removeUserEmail();
                      signedIn = false;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    }
                  });
                }
              },
              child: Container(
                width: 80,
                height: 25,
                decoration: BoxDecoration(
                  color: Color(0xFF2679B5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: confirmLogout ? Center(child: Text("Confirm",style: TextStyle(fontSize: 13),)) : Center(child: Text("Log Out",style: TextStyle(fontSize: 13),)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 95,
                    height: 105,
                    decoration: BoxDecoration(
                        color: Color(0xFF1640A8),
                        borderRadius: BorderRadius.circular(1200)),
                    child: Container(
                      width: 85,
                      height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1200),
                        color: const Color(
                            0xFF9EDBFF), // Set the desired background color for the container
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.all(10), // Adjust the padding as needed
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _uploadProfilePicture();
                                });
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(1200),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundImage: _image != null
                                        ? FileImage(_image!)
                                        : null,
                                    child: Visibility(
                                        visible: imageVisible,
                                        child: Icon(Icons.image)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${profileName}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SettingsPage()),
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "${profileEmail}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNewLocationPage()),
                                        );
                                      });
                                    },
                                    child: Icon(
                                      Icons.location_on,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.add_circle,
                                      size: 16,
                                      color: Color(0xFF9EDBFF),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 15, right: 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Container(
            //             width: 80,
            //             height: 25,
            //             decoration: BoxDecoration(
            //               border: Border.all(
            //                 color: Colors.white,
            //                 width: 1,
            //               ),
            //             ),
            //             child: Center(
            //               child: Text(
            //                 "EDIT PROFILE",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 10,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Row(
            //             children: [
            //               Icon(
            //                 Icons.star,
            //                 color: Color(0xFF1640A8).withOpacity(0.5),
            //               ),
            //               Icon(
            //                 Icons.star,
            //                 color: Color(0xFF1640A8).withOpacity(0.5),
            //               ),
            //               Icon(
            //                 Icons.star,
            //                 color: Color(0xFF1640A8).withOpacity(0.5),
            //               ),
            //               Icon(
            //                 Icons.star,
            //                 color: Color(0xFF1640A8).withOpacity(0.5),
            //               ),
            //               Icon(
            //                 Icons.star,
            //                 color: Color(0xFFD9D9D9),
            //               )
            //             ],
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Color(0xFFEBF4FA),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                      "Places to approve",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  FutureBuilder(future:getPosts(approved_only: false),  builder:(context, snapshot) {
                    if(snapshot.hasData){
                      PageController _pageController = PageController();
                      List<NewPLace> places_to_approve = [];
                      for(NewPLace c in snapshot.data!){
                          places_to_approve.add(c);
                      }
                     if(index_of_approving < places_to_approve.length){
                      var lat_lng = places_to_approve[index_of_approving].Location.split(' ');
                      GeoPoint place = GeoPoint(latitude: double.parse(lat_lng[0]), longitude: double.parse(lat_lng[1]));
                      
                     // MapController _mapController = MapController.withPosition(initPosition: place);
                        return Container(
                          height: 700,
                          child: 
                        Column(children: [
                          Text(places_to_approve[index_of_approving].Name, style: TextStyle(
                        color: Colors.black,
                        
                        fontSize: 27,
                      ),),
                          FutureBuilder(future: getImages(places_to_approve[index_of_approving].place_id), builder:(context, image_snapshot){
                            if(image_snapshot.hasData){
                              return 
                              
                              Stack(
              children: [
                Container(
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: image_snapshot.data!.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        image_snapshot.data![index],
                        fit: BoxFit.cover,
                      );
                    },
                  ) 
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFF0C0B0B),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "${_currentIndex + 1}/${image_snapshot.data!.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                          Align(alignment: Alignment.topLeft,child:
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(place: place)));
                          }, child:
                          Text('Go map'))),

                          Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: Container(
                        //color: Colors.white,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            softWrap: true,
                            places_to_approve[index_of_approving].Description,
                           // style: TextStyle(color: Color(0xFF3797D0)),
                           style: TextStyle(color: Color(0xFF212656), fontSize: 16)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6,),
                    
                    Center(
                      child: Container(
                        width: 320,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                      
                          Container(height: 50, width: 100,
                            decoration: BoxDecoration(color:Color.fromARGB(255, 248, 93, 93) , shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(25))),
                            child: TextButton(
                              
                              onPressed: ()async{
                              index_of_approving = index_of_approving+1;
                              setState(() {
                                _currentIndex = 0;
                              });
                              
                            }, child: Text("Skip", style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ))),
                          ),
                          Container(height: 50, width: 100,
                            decoration: BoxDecoration(color: Color.fromARGB(255, 98, 238, 105), shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(25))),
                            child: TextButton(onPressed: ()async{
                      
                            String? token = await getUserToken();
                            places_to_approve[index_of_approving].Is_Approved = true;
                            String jsonString = jsonEncode(places_to_approve[index_of_approving].toJson());
                            ///////////////
                            http.Response responsePost = await http.put(
                              
                            Uri.parse("https://paveltrty.pythonanywhere.com/api/place/update/${places_to_approve[index_of_approving].place_id}/"),
                            headers: {'Content-Type': 'application/json'},
                            body: jsonString,
                            
                          );
                          if(responsePost.statusCode==200){
                            print('Cool');
                          }
                          index_of_approving = index_of_approving+1;
                          setState(() {
                             _currentIndex = 0;
                          });
                          }, child: Text("Approve", style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ))),
                          ),
                          
                        ],),
                      ),
                    )





                        ]

                        
                        
                        
                        )
                        ,);
                     }else {
                      return Center(
                        child: Column(
                          children: [
                            Icon(Icons.castle_rounded, size: 100,),
                            Text('Nothing to approve')
                          ],
                        ),
                      );
                     }
                      
                    }else{
                      return Container(width: double.infinity, height: 400, child: Center(child: CircularProgressIndicator()));
                    }
                  },)
                 
                 ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
