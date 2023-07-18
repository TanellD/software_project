import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:software_project/addNewLocationPage.dart' as bgbhjbf;
import 'package:software_project/addNewReview.dart';
import 'package:software_project/big_map.dart';
import 'package:software_project/connection.dart';
import 'package:software_project/distance.dart';
import 'package:software_project/person_account.dart';
import 'package:software_project/searchResultPage.dart';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:software_project/loginPage.dart';
import 'package:software_project/main.dart';
import 'package:software_project/profilePage.dart';
import 'package:software_project/searchResultPage.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';





class MainPageView extends StatefulWidget {
  NewPLace album; 
  MainPageView({required this.album});
  @override
  _MainPageViewState createState() => _MainPageViewState(futureAlbum: this.album);
}

class _MainPageViewState extends State<MainPageView>  {
  int selected_photo_index = 0;


  final NewPLace futureAlbum;

  ScrollController _scrollController = ScrollController();
  late MapController _mapController;

  late GeoPoint place;
  

  @override
  void dispose() {
    _mapController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
_MainPageViewState({required this.futureAlbum}){
place = GeoPoint(latitude: futureAlbum.latitude, longitude: futureAlbum.longitude);
_mapController = MapController(initPosition: place);

}


@override
  void initState() {
    place = GeoPoint(latitude: futureAlbum.latitude, longitude: futureAlbum.longitude);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF4FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios, color: Colors.black), // Change the icon to your desired icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
            actions: [IconButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>signedIn? AddNewReviewPage(album: futureAlbum,):LoginPage())), icon: 
            
            SingleChildScrollView(child:  Column(children: [Icon(
                  Icons.add_box_rounded,
                  color: Colors.black,
                  
                  
                ), Text(
                  "Review",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 9),
                )])),
                
                
                ), SizedBox(width: 10, height: 60,)],

      ),
      body:  SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: 
        Column(

                  children: [
                    Container(
                      height: 350,
                      width: 420,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          PageView.builder(
                              dragStartBehavior: DragStartBehavior.start,
                              itemCount: futureAlbum.images.length,
                              pageSnapping: true,
                              controller: PageController(
                                viewportFraction: 1,
                              ),
                              onPageChanged: (page) {
                                setState(() {
                                  selected_photo_index = page ;
                                });
                              },
                              itemBuilder: (context, pagePosition) {
                                return Container(
                                  margin: EdgeInsets.all(0),
                                  child: SizedBox(
                                    child: Image.network(
                                      alignment: Alignment.topCenter,
                                      futureAlbum.images[
                                          pagePosition]!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
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
                                  "${selected_photo_index+1}/${futureAlbum.images.length}",
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            futureAlbum.Name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 27),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(future: Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high),builder: (context, snapshot){
                              if(snapshot.hasData){
                                return Text(
                              distance(dist(snapshot.data!, place)),
                              style: TextStyle(color: Colors.grey[600], fontSize: 16)
                            );
                              } else {
                                return Text(
                             'km',
                              style: TextStyle(color: Colors.grey[600], fontSize: 16)
                            );
                              }
                            }
                              
                            )
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                      child:Align(alignment: Alignment.topLeft,child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(futureAlbum.Tags.split(', ').length, (index) => Text(futureAlbum.Tags.split(', ')[index], style: TextStyle(color: Colors.grey[600], fontSize: 16),)) ,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, left: 15),
                      child: Row(
                        children: [
                          Row(
                              children: List.generate(
                                  5,
                                  (index) => Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: Icon(
                                          futureAlbum.rating.ceil() >=
                                                  index + 1
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Color.fromARGB(255, 247, 230, 78),
                                        ),
                                      ))),
                          // Padding(
                          //   padding: const EdgeInsets.all(1),
                          //   child: Text(
                          //       "${/*futureAlbum.number_of_comments*/5} reviews"),
                          // )
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child:Text(
                            "Take a glance",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
  //color: Colors.white,
  width: double.infinity,
  child: Column(children: [
    
    Container(height: 200, width: 390, child:
  
  OSMFlutter( isPicker: false, showZoomController: true, showDefaultInfoWindow: false, maxZoomLevel: 19, androidHotReloadSupport: false, initZoom: 10, controller: _mapController,
  // userLocationMarker: UserLocationMaker(directionArrowMarker: const MarkerIcon(icon:Icon(Icons.location_on_sharp, color: Colors.red, size: 48,)), personMarker: MarkerIcon(icon:Icon(Icons.person, color: Colors.yellow,))),
  // markerOption: MarkerOption(defaultMarker: const MarkerIcon(icon:Icon(Icons.location_on_sharp, color: Colors.red,))),
  onMapIsReady: (isReady)async=>{
    if(isReady){
      _mapController.addMarker(place, markerIcon: MarkerIcon(icon:Icon(Icons.location_on_sharp, color: Colors.red, size: 48,))),
      //await _mapController.drawRoad(GeoPoint(latitude: User.position.latitude, longitude: User.position.longitude), place, roadOption: RoadOption(roadColor: Colors.purple, roadWidth: 50))
      _mapController.listenerMapSingleTapping.addListener(() {
        if(_mapController.listenerMapSingleTapping.value!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(place: place)));
        }
      })
    }
  },
  ),
  ),
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   children: [
  //     Expanded(
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 8),
  //         child: Container(
  //           width: 100,
  //           child: Text(
  //             softWrap: true,
  //             futureAlbum.address,
  //             style: TextStyle(color: Colors.grey[600], fontSize: 16)
  //           ),
  //         ),
  //       ),
  //     ),
  //     Align(
  //       alignment: Alignment.bottomRight,
  //       child: Container(
  //         width: 180,
  //         child: Padding(
  //           padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
  //           child: Container(alignment: Alignment.bottomRight,
  //             child: FutureBuilder(future: Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high),builder: (context, snapshot){
  //                         if(snapshot.hasData){
  //                           return Text(
  //                         distance(dist(snapshot.data!, place)),
  //                         style: TextStyle(color: Colors.grey[600], fontSize: 16)
  //                       );
  //                         } else {
  //                           return Text(
  //                        'km',
  //                         style: TextStyle(color: Colors.grey[600], fontSize: 16)
  //                       );
  //                         }
  //                       }
                          
  //                       )
  //           ),
  //         ),
  //       ),
  //     )
  //   ],
  // )
  
  ]),
),
                    ),
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
                            futureAlbum.Description,
                           // style: TextStyle(color: Color(0xFF3797D0)),
                           style: TextStyle(color: Color(0xFF212656), fontSize: 16)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "What people feel",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       "Reviews",
                    //       style: TextStyle(color: Colors.black, fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                    // Column(children: 
                    // List.generate(futureAlbum.comments.length, (index) => CommentBox(comment: futureAlbum.comments[index]))
                    // ,)
                    FutureBuilder(future: getComments(id: futureAlbum.place_id), builder:(context, snapshot) {
                      if(snapshot.hasData){
                        return Column(children: 
                          List.generate(snapshot.data!.length, (index) => CommentBox(comment: snapshot.data![index]))
                        );
                      }
                      else {
                        return Text('');
                      }
                    },)
                    
                    ],
                )
        ///
        ///
        ////////////////////////////////
        
        ,
      ),
      
      floatingActionButton: SizedBox(
        width: 30,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Color(0xFFD4E8F4),
          child: Icon(Icons.arrow_upward),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}






Future<List<Comment>> getComments({required int id}) async {
  List<Comment> comments = [];
    ///Exercise 1 call API here
    //await Future.delayed(Duration(seconds: 3), () {});
    print("Connecting to Internet");
    
    Uri uri = Uri.parse("https://paveltrty.pythonanywhere.com/api/place/comment/$id/");
    Response response = await get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body) as List;
      list.forEach((json) {
        Comment comment = Comment.fromJson(json);
        comments.add(comment);
      });
    } else {
      print("error");
    }
    return comments;
  }

class Comment {
  late String Date ;
  late int Rating;
  String Description = '';
  Comment(
      {required this.Date,
      required this.Rating,
      required this.Description,
      });
        Comment.fromJson(Map<String, dynamic> json) {
    Date = json["date"];
    Rating = json["rating"];
    Description = json["Description"];
  }

}

class CommentBox extends StatefulWidget{
  Comment comment;
  CommentBox({required this.comment});
  @override
  State<StatefulWidget> createState() {
    return _CommentBoxState();
  }
}


class _CommentBoxState extends State<CommentBox>{
  //PageController _pageController = PageController();
  build(context){
    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 22.5,
                                      backgroundColor: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                        children: List.generate(
                                            5,
                                            (index) => Icon(
                                                  widget.comment
                                                              .Rating >=
                                                          index + 1
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Color.fromARGB(255, 247, 230, 78),
                                                ))),
                                    Container(
                                      height: 40,
                                      width: 180,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(widget.comment
                                                .Date, 
                                                style: TextStyle(color: Colors.grey[600], fontSize: 13)
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ),
                                Align(alignment: Alignment.centerLeft,child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.comment.Description,
                                  // style: TextStyle(color: Color(0xFF3797D0)),
                                  style: TextStyle(color: Color(0xFF212656), fontSize: 14)
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  
  }
}
