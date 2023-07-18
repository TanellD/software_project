import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:software_project/big_map.dart';
import 'package:software_project/connection.dart';
import 'package:software_project/filter.dart';
import 'dart:async';
import 'dart:io';
import 'package:software_project/mainPageView.dart';
import 'package:software_project/person_account.dart';
import 'package:software_project/distance.dart';
import 'package:software_project/sort_place.dart';



class Comment {
  List<String> images_addresses = [];
  int given_rating = 0;
  int user_id = 0;
  String text = '';
  String date_of_post='';
  Comment(
      {required this.date_of_post,
      required this.given_rating,
      required this.user_id,
      required this.text,
      required this.images_addresses});
}

class Album {
  final List<String> images_adresses;
  final int number_of_images;
  final String place_name;
  final double rating;
  final int distance;
  final int number_of_comments;
  final String description;
  final String address;
  final String country;
  final double latitude;
  final double longtitude;
  final List<Comment> comments;
  final List<String> tags;

   Album({
    required this.images_adresses,
    required this.country,
    required this.distance,
    required this.number_of_images,
    required this.number_of_comments,
    required this.place_name,
    required this.rating,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longtitude,
    required this.comments,
    required this.tags
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      number_of_images: json['number_of_images'],
      images_adresses: json['images_adresses'],
      number_of_comments: json['number_of_comments'],
      place_name: json['place_name'],
      rating: json['rating'],
      description: json['description'],
      address: json['address'],
      longtitude: json['longtitude'],
      latitude: json['latitude'],
      comments: json['comments'],
      country: "Russia",
      distance: json['distance'],
      tags: []
    );
  }
}

// List<Album> getPage(List<NewPLace> listOfNewPlaces){
//   List<Album> allPlace = [
//     Album(
//       country:'Russia',
//       distance: 50,
//     images_adresses: [
//       'https://i.pinimg.com/originals/78/5b/4e/785b4e5fb211ec39d8f7daec2185f09a.jpg',
//       'https://i.pinimg.com/originals/77/25/04/77250495fe3e7ce63eed1d8442443476.jpg',
//       'https://i.pinimg.com/originals/30/cf/74/30cf74548090e3305b717256a9c86ec1.jpg',
//       'https://i.pinimg.com/originals/9d/c9/1f/9dc91fa2a298bfd5c62a54a14416cbf6.jpg',
//       'https://i.pinimg.com/originals/fb/d5/0b/fbd50b08f0ec75b5c64d3776a3aa1b07.jpg',
//       'https://i.pinimg.com/originals/f4/ca/da/f4cada68d12213ec4ff1beb9a7fbbbd2.jpg',
//       'https://i.pinimg.com/originals/03/43/7b/03437b691d5dbc77c0be5132109e0ff2.jpg',
//     ],
//     number_of_images: 7,
//     number_of_comments: 5,
//       address: 'Krmelst.,13, Kazan 420014, Russia',
//       place_name: listOfNewPlaces[0].Name,
//       latitude: double.parse(listOfNewPlaces[0].Location.split(' ')[0]),
//       longtitude: double.parse(listOfNewPlaces[0].Location.split(' ')[1]),
//       description: listOfNewPlaces[0].Description,
//       tags:listOfNewPlaces[0].Tags.split(', ').map((e) => e.toLowerCase()).toList(),
          
//           rating: listOfNewPlaces[0].rating.toDouble(),//
//       comments: List.generate(
//           5,
//           (index) => Comment(
//             date_of_post: "Feb 28, 2023",
//               given_rating: 4,
//               user_id: index,
//               text:
//                   "I stayed for a week , the scenery is good, a city with a very slow pace of life, although the attraction are not as Moscow and St. Petersburg, if you don’t have time to travel freely, it is recommended to stay a few more days",
//               images_addresses: 
//               List.generate(
//                   3,
//                   (index) =>
//                       "https://th.bing.com/th/id/R.493203561946f5d20b074259c327e604?rik=F4VZkavdu%2frPlQ&pid=ImgRaw&r=0")
//                       )
//                       )),
//     Album(tags:listOfNewPlaces[1].Tags.split(', ').map((e) => e.toLowerCase()).toList(),images_adresses: ['https://img.freepik.com/premium-photo/backpack-asian-man-on-the-mountain-see-view-panorama-the-beautiful-nature-landscape-of-the-sea-adventure-on-vacation-travel-leisure-to-asia-on-mu-ko-ang-thong-island-national-park-background-thailand_536080-1002.jpg?w=2000',
//     'https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000',
//     ], country: 'Russia', distance: 67, number_of_images: 2, number_of_comments: 1, place_name: listOfNewPlaces[1].Name, rating: 3.5, description: listOfNewPlaces[1].Description, address: 'Bridge 123st, Russia', 
//     latitude: double.parse(listOfNewPlaces[1].Location.split(' ')[0]),
//       longtitude: double.parse(listOfNewPlaces[1].Location.split(' ')[1]),
//      comments: [Comment(date_of_post: 'June 17, 1066', given_rating: 1, user_id: 9, text: 'I love the place', images_addresses: ['https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000'])]),
//   Album(tags:listOfNewPlaces[1].Tags.split(', ').map((e) => e.toLowerCase()).toList(),images_adresses: ['https://img.freepik.com/premium-photo/backpack-asian-man-on-the-mountain-see-view-panorama-the-beautiful-nature-landscape-of-the-sea-adventure-on-vacation-travel-leisure-to-asia-on-mu-ko-ang-thong-island-national-park-background-thailand_536080-1002.jpg?w=2000',
//     'https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000',
//     ], country: 'Russia', distance: 67, number_of_images: 2, number_of_comments: 1, place_name: listOfNewPlaces[1].Name, rating: 3.5, description: listOfNewPlaces[1].Description, address: 'Bridge 123st, Russia', latitude: 55.79815, longtitude: 49.07829, comments: [Comment(date_of_post: 'June 17, 1066', given_rating: 1, user_id: 9, text: 'I love the place', images_addresses: ['https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000'])]),
// Album(tags:listOfNewPlaces[1].Tags.split(', ').map((e) => e.toLowerCase()).toList(),images_adresses: ['https://img.freepik.com/premium-photo/backpack-asian-man-on-the-mountain-see-view-panorama-the-beautiful-nature-landscape-of-the-sea-adventure-on-vacation-travel-leisure-to-asia-on-mu-ko-ang-thong-island-national-park-background-thailand_536080-1002.jpg?w=2000',
//     'https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000',
//     ], country: 'Russia', distance: 67, number_of_images: 2, number_of_comments: 1, place_name: listOfNewPlaces[1].Name, rating: 3.5, description: listOfNewPlaces[1].Description, address: 'Bridge 123st, Russia', latitude: 55.79815, longtitude: 49.07829, comments: [Comment(date_of_post: 'June 17, 1066', given_rating: 1, user_id: 9, text: 'I love the place', images_addresses: ['https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000'])]),

  
//   ];



//   return allPlace;
// }


/*
 List<Album> allPlace = [
    Album(
      country:'Russia',
      distance: 50,
    images_adresses: [
      'https://i.pinimg.com/originals/78/5b/4e/785b4e5fb211ec39d8f7daec2185f09a.jpg',
      'https://i.pinimg.com/originals/77/25/04/77250495fe3e7ce63eed1d8442443476.jpg',
      'https://i.pinimg.com/originals/30/cf/74/30cf74548090e3305b717256a9c86ec1.jpg',
      'https://i.pinimg.com/originals/9d/c9/1f/9dc91fa2a298bfd5c62a54a14416cbf6.jpg',
      'https://i.pinimg.com/originals/fb/d5/0b/fbd50b08f0ec75b5c64d3776a3aa1b07.jpg',
      'https://i.pinimg.com/originals/f4/ca/da/f4cada68d12213ec4ff1beb9a7fbbbd2.jpg',
      'https://i.pinimg.com/originals/03/43/7b/03437b691d5dbc77c0be5132109e0ff2.jpg',
    ],
    number_of_images: 7,
    number_of_comments: 5,
      address: 'Krmelst.,13, Kazan 420014, Russia',
      place_name: 'Kul Sharif Mosque',
      latitude: 55.79835,
      longtitude: 49.10517,
      description:
          "The Kul Sharif Mosque, located in Kazan, Russia, is a magnificent architectural gem and a symbol of the city's rich cultural heritage. Built in the 16th century, it stands as a testament to the city's Islamic roots and is one of the largest mosques in Europe. With its stunning blue and white domes and intricate designs, the Kul Sharif Mosque attracts visitors from around the world, offering a glimpse into Kazan's diverse and vibrant history.",
      rating: 4.9,
      comments: List.generate(
          5,
          (index) => Comment(
            date_of_post: "Feb 28, 2023",
              given_rating: 4,
              user_id: index,
              text:
                  "I stayed for a week , the scenery is good, a city with a very slow pace of life, although the attraction are not as Moscow and St. Petersburg, if you don’t have time to travel freely, it is recommended to stay a few more days",
              images_addresses: List.generate(
                  3,
                  (index) =>
                      "https://th.bing.com/th/id/R.493203561946f5d20b074259c327e604?rik=F4VZkavdu%2frPlQ&pid=ImgRaw&r=0")))),
    Album(images_adresses: ['https://img.freepik.com/premium-photo/backpack-asian-man-on-the-mountain-see-view-panorama-the-beautiful-nature-landscape-of-the-sea-adventure-on-vacation-travel-leisure-to-asia-on-mu-ko-ang-thong-island-national-park-background-thailand_536080-1002.jpg?w=2000',
    'https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000',
    ], country: 'Russia', distance: 67, number_of_images: 2, number_of_comments: 1, place_name: 'Bridge Millenium', rating: 3.5, description: 'Beatiful bridge in a middle of a place', address: 'Bridge 123st, Russia', latitude: 55.79815, longtitude: 49.07829, comments: [Comment(date_of_post: 'June 17, 1066', given_rating: 1, user_id: 9, text: 'I love the place', images_addresses: ['https://img.freepik.com/premium-photo/aerial-view-ang-thong-national-marine-park-at-ko-samui-smui-suratthani-thailand_35024-769.jpg?w=2000'])]),
  ];
*/


Future<List<NewPLace>> getPosts({List<String> tags=const [''], String query='', int sortId=0, bool approved_only = true}) async {
  List<NewPLace> posts=[];
    ///Exercise 1 call API here
    //await Future.delayed(Duration(seconds: 3), () {});
    print("Connecting to Internet");
    String http_tags = tags.join(', ');
    http_tags = http_tags.replaceAll(' ', '+');
    String http_query = query.replaceAll(' ', '+');
    
    Uri uri = Uri.parse("https://paveltrty.pythonanywhere.com/api/place/?Name__icontains=$http_query&Tags__contains=$http_tags");
    Response response = await get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body) as List;
      list.forEach((json) {
        NewPLace post = NewPLace.fromJson(json);
        var lat_lng = post.Location.split(' ');
        post.latitude = double.parse(lat_lng[0]);
        post.longitude = double.parse(lat_lng[1]);
        post.Distance = dist(User.position, GeoPoint(latitude: double.parse(lat_lng[0]) , longitude: double.parse(lat_lng[1])));
        if(post.Is_Approved == approved_only){
          posts.add(post);
        }
        
      });
    } else {
      print("error");
    }
    switch(sortId){
      case(0):
        posts.sort((a, b) => a.rating.compareTo(b.rating));
        posts = posts.reversed.toList();
        break;
      case(1):
        posts.sort((a, b) => a.Distance.compareTo(b.Distance));
        //posts = posts.reversed.toList();
        break;
    }
    return posts;
  }

// Center buildLoadingView() => Center(child: CircularProgressIndicator());
//   Widget buildFutureBuilder() {
//     return FutureBuilder<List<NewPLace>>(
//       future: getPosts(),
//       builder: (context, snapshot) {
//         // Error
//         if (snapshot.hasError) {
//           return Text(
//             "Error",
//             style: TextStyle(fontSize: 50),
//           );
//         }
//         // Done
//         if (snapshot.connectionState == ConnectionState.done) {
//           List<NewPLace> posts = snapshot.data as List<NewPLace>;
//           //return buildPostList(posts);
//         }
//         // Loading
//         return buildLoadingView();
//       },
//     );
//   }


class ResultBox extends StatefulWidget {
  final NewPLace album;

  ResultBox({
    required this.album,
  });

  @override
  _ResultBoxState createState() => _ResultBoxState();
}


class _ResultBoxState extends State<ResultBox> {
   late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPageView(
              album: widget.album,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Container(
        color: Colors.white,
        child: FutureBuilder(future: getImages(widget.album.place_id),builder: (context, snapshot) {
          if(snapshot.hasData){
            widget.album.images = snapshot.data!;
            return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.album.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.album.images[index]!,
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
                        "${_currentIndex + 1}/${widget.album.images.length}",
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
            Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Container(
                    width: MediaQuery.of(context).size.width/2-40,
                    child: Text(
                      softWrap: true,
                      widget.album.Name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: Icon(
                            Icons.star,
                            color: i < widget.album.rating
                                ? Color.fromARGB(255, 247, 230, 78)
                                : Colors.grey,
                          ),
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.all(1),
                      //   child: Text(/*widget.album.number_of_comments.toString()*/'5', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 140, child:
                  FutureBuilder(future: placemarkFromCoordinates(widget.album.latitude, widget.album.longitude),builder: (context, loc) {
                    if(loc.hasData){
                      widget.album.physical_address = '${loc.data![0].street}, ${loc.data![0].name}, ${loc.data![0].locality}';
                      return Text(
                    softWrap: true,
                    widget.album.physical_address,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16)
                  );
                    }
                    else{
                      return Text('');
                    }
                  },)
                  
                  ),
                  
                  Container(alignment: Alignment.bottomRight,
                    child: FutureBuilder(future: Geolocator.getCurrentPosition(), builder:(context, snapshot) {
                      if(snapshot.hasData){
                        var lat_lng = widget.album.Location.split(' ');
                        return Text(
                      distance(dist(snapshot.data!, GeoPoint(latitude: double.parse(lat_lng[0]), longitude: double.parse(lat_lng[1])))),
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    );
                      } else {
                        return Text('');
                      }
                    },),
                  )
                  
                ],
              ),
            ),
            SizedBox(height: 6,)
          ],
        );

          }else {
            return  Center(child: CircularProgressIndicator(),);
          }

        },) 
      ),
      ),
    );
  }
}




class SearchResultsPage extends StatefulWidget {
  final String headerMessage;
  List<String> tags;
  String query; 
  int sortId;

  SearchResultsPage({required this.headerMessage, this.tags=const [], this.query='' , this.sortId=0});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
 ScrollController _scrollController = ScrollController();
  List<Album> albumList = [];
  late Future<List<NewPLace>> futurePage;


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futurePage = getPosts(tags: widget.tags, query: widget.query, sortId: widget.sortId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3797D0),
        elevation: 0,
        toolbarHeight: 110,
        title: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                widget.headerMessage,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 224,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.41),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                      hintText: 'find a place',
                      hintStyle: TextStyle(
                        color: Color(0xFF000000).withOpacity(0.24),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      // Handle text field tap if needed
                    },
                    onChanged: (String value) {
                      // Handle text field changes if needed
                    },
                    onSubmitted: (String value) {
                      // Navigate to a new page with search results
                      widget.query = value;
                      setState(() {
                        
                      });
                      
                      
                    },
                  ),
                ),
                InkWell(child:
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11)),
                  child: Icon(
                    Icons.filter_alt,
                    color: Color(0xFF3797D0),
                  ),
                ),
                onTap: ()async {
                  if(widget.headerMessage.toLowerCase()!='search result'){
                  widget.sortId = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Sorts(given_result: widget.sortId,)));
                  } else {
                    List<dynamic> given_result = [['rating', 'distance'][widget.sortId]];
                    given_result.addAll(widget.tags);
                    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Filters(given_result: given_result,)));
                    switch(result[0]){
                      case('rating'):
                        widget.sortId = 0;
                        break;
                      case('distance'):
                        widget.sortId = 1;
                        break;
                    }
                    widget.tags=[];
                    for(int i = 1; i < result.length; ++i){
                      widget.tags.add(result[i]);
                    }
                  }
                  setState(() {
                    
                  });
                },
                )
              ],
            )
          ],
        ),
        leading: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: Color(0xFFEBF4FA),
      body: SingleChildScrollView(
       controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: FutureBuilder<List<NewPLace>> (
             future: getPosts(tags: widget.tags, query: widget.query, sortId: widget.sortId),
             builder: (context, snapshot) {
               if (snapshot.hasData) {
                 List<NewPLace> albums = snapshot.data!;
                 return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                   child: Container(
                    height: MediaQuery.of(context).size.height - 150,
                     child: ListView.builder(
                      primary: true,
                       scrollDirection: Axis.vertical,
                       physics: AlwaysScrollableScrollPhysics(),
                       //controller: ScrollController(),
                       shrinkWrap: true,
                       itemCount: albums.length,
                       itemBuilder: (context, index) {
                         NewPLace album = albums[index];
                         return ResultBox(album: album);
                       },
                     ),
                   ),
                 );
               } else if (snapshot.hasError) {
                 return Text("Error: ${snapshot.error}");
               }
               // Show a loading indicator while waiting for the data
               return Align(
                alignment: Alignment.center,
                child: Container( height: 600, width: 395, child: Center(child: CircularProgressIndicator())));
             },
           ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchResultsPage(
      headerMessage: "Search Results",
    ),
  ));
}



