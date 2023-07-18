import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:software_project/admin_profile_page.dart';
import 'package:software_project/ligthBulbPage.dart';
import 'package:software_project/loginPage.dart';
import 'package:software_project/profilePage.dart';
import 'package:software_project/searchResultPage.dart';
import 'package:software_project/search_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:software_project/person_account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:software_project/settingPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPage extends StatefulWidget {
  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    // Request storage permission
    var status = await Permission.storage.request();
    print('Storage permission status: $status');

    // Request camera permission
    status = await Permission.camera.request();
    print('Camera permission status: $status');

    // Request location permission
    status = await Permission.location.request();
    print('Location permission status: $status');
    permissionGranted = true;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Request'),
      ),
      body: Center(
        child: Text('Requesting Permissions...'),
      ),
    );
  }
}


Future<Position> getPosition() async{
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}


List<String> emails_of_admins=[
  'pavel.m.sharygin@gmail.com',
  'p.sharygin@innopolis.university',
  //'g.oki@innopolis.university',
  'ezekielgadzama23@gmail.com',
  //'ezekielgadzama17@gmail.com',
  //'davydov-danil@bk.ru',

];

class ImageSquare {
  String text = '';
  String photo_address = '';

  ImageSquare(this.text, this.photo_address);

  Widget build() {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                color: Color(0xFF212656),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        image: DecorationImage(
          opacity: 1,
          image: NetworkImage(photo_address),
          fit: BoxFit.cover,
        ),
      ),
      width: 160,
      height: 160,
    );
  }
}




bool signedIn = false;
Widget currentPage = HomePage();



bool permissionGranted = false;



void main(){
  WidgetsFlutterBinding.ensureInitialized();
  //DevicePreviewState.initialized(devices: devices, locales: locales, data: data)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_) {
runApp(MyApp());
});
  
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (snapshot.data == true) {
              signedIn = true;
              print(signedIn);
            }
            return HomePage();
          }
        },
      ),
    );
  }
}


	final storage = FlutterSecureStorage();



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Icon SignInIcon = Icon(Icons.person);

class _HomePageState extends State<HomePage>
  
    with SingleTickerProviderStateMixin {

    Future<Position>? position = getPosition();
     bool isPhotoMode = true;
  bool isFrontCamera = false;

  File? imageViaCamera;

  Future<void> pickImageViaCamera() async {
    try {
      final imagePicker = ImagePicker();
      final imageViaCamera =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (imageViaCamera == null) return;
      final imageTemporary = File(imageViaCamera.path);
      setState(() {
        this.imageViaCamera = imageTemporary;
      });
      // Save the image to the gallery
      final galleryPath = await _getGalleryPath();
      final fileName = path.basename(imageTemporary.path);
      final savedImagePath =
          await imageTemporary.copy('$galleryPath/$fileName');
      print('Image saved to: $savedImagePath');
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<String> _getGalleryPath() async {
    final storageDir = await getExternalStorageDirectory();
    final galleryDir = Directory('${storageDir!.path}/Pictures');
    galleryDir.createSync(recursive: true);
    return galleryDir.path;
  }

  Future<String> _getGalleryPathMovies() async {
    final storageDir = await getExternalStorageDirectory();
    final galleryDir = Directory('${storageDir!.path}/Movies');
    galleryDir.createSync(recursive: true);
    return galleryDir.path;
  }

  File? videoViaCamera;

  Future<void> pickVideoViaCamera() async {
    try {
      final imagePicker = ImagePicker();
      final videoViaCamera =
          await imagePicker.pickVideo(source: ImageSource.camera);
      if (videoViaCamera == null) return;
      final videoTemporary = File(videoViaCamera.path);
      setState(() {
        this.videoViaCamera = videoTemporary;
      });
      // Save the video to the gallery
      final galleryPath = await _getGalleryPathMovies();
      final fileName = videoTemporary.path.split('/').last;
      final savedVideoPath =
          await videoTemporary.copy('$galleryPath/$fileName');
      print('Video saved to: $savedVideoPath');
    } catch (e) {
      print('Failed to pick video: $e');
    }
  }
 @override
  Widget build(BuildContext context) {
    // Retrieve the user token from secure storage
    if (!signedIn) {
      setState(() {
        SignInIcon = Icon(Icons.login);
      });
    }else{
      setState(() {
        SignInIcon = Icon(Icons.person);
      });
    }
    return FutureBuilder(
      future: position,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User.position = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFFEBF4FA),
              toolbarHeight: 170,
              title: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Code to navigate to a new page or handle the search bar tap
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.41),
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                hintText: 'Discover stunning destination',
                                hintStyle: TextStyle(
                                  color: Color(0xFF000000).withOpacity(0.24),
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchResultsPage(
                                      headerMessage: 'Search Result',
                                    ),
                                  ),
                                );
                              },
                              onChanged: (String value) {
                                // Handle text field changes if needed
                              },
                              onSubmitted: (String value) {
                                // Navigate to a new page with search results
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchResultsPage(
                                      headerMessage: "Search Results",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "KazanTravel",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3797D0)),
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0xFFEBF4FA),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 4),
                        child: InkWell(
                          onTap: () {
                            // Code to navigate to a new page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResultsPage(
                                        headerMessage: "Historical Landmark ",
                                        tags: ['historical landmark'],
                                      )),
                            );
                          },
                          child: ImageSquare("Historical Landmark",
                                  "https://gotosiberia.com/img/kazan/farmer_palace_m.jpg")
                              .build(),
                        ),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 16, right: 15),
                            child: InkWell(
                              onTap: () {
                                // Code to navigate to a new page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchResultsPage(
                                              headerMessage:
                                                  "Cultural and Architectural",
                                              tags: [
                                                'cultural and architectural'
                                              ])),
                                );
                              },
                              child: ImageSquare("Cultural and Architectural",
                                      "https://upload.wikimedia.org/wikipedia/commons/b/bd/%D0%94%D0%B2%D0%BE%D1%80%D0%B5%D1%86_%D0%B7%D0%B5%D0%BC%D0%BB%D0%B5%D0%B4%D0%B5%D0%BB%D1%8C%D1%86%D0%B5%D0%B22.jpg")
                                  .build(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 4),
                        child: InkWell(
                          onTap: () {
                            // Code to navigate to a new page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResultsPage(
                                      headerMessage: "Museums and Galleries",
                                      tags: ['museums and galleries'])),
                            );
                          },
                          child: ImageSquare("Museums and Galleries",
                                  "https://img.theculturetrip.com/wp-content/uploads/2018/03/1980676.jpg")
                              .build(),
                        ),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 16, right: 15),
                            child: InkWell(
                              onTap: () {
                                // Code to navigate to a new page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchResultsPage(
                                        headerMessage:
                                            "Sports and Entertainment Venues",
                                        tags: [
                                          'sports and entertainment venues'
                                        ]),
                                  ),
                                );
                              },
                              child: ImageSquare(
                                      "Sports and Entertainment Venues",
                                      "https://www.sportacadem.ru/files/2021/image/1/s3.jpg")
                                  .build(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 4, bottom: 15),
                        child: InkWell(
                          onTap: () {
                            // Code to navigate to a new page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResultsPage(
                                        headerMessage:
                                            "Parks and Natural Attractions",
                                        tags: ['parks and natural attractions'],
                                      )),
                            );
                          },
                          child: ImageSquare("Parks and Natural Attractions",
                                  "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/0e/b4/c7/caption.jpg?w=500&h=400&s=1")
                              .build(),
                        ),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 16, right: 15, bottom: 15),
                            child: InkWell(
                              onTap: () {
                                // Code to navigate to a new page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchResultsPage(
                                              headerMessage:
                                                  "Cultural Festival and Events",
                                              tags: [
                                                'cultural festivals and events'
                                              ])),
                                );
                              },
                              child: ImageSquare("Cultural Festival and Events",
                                      "https://upload.wikimedia.org/wikipedia/commons/9/9f/Kazan_fan_fest_WC_2018.jpg")
                                  .build(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.home, color: Color(0xFF3797D0)),
                        ),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color(0xFF3797D0),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: 0,
                              child: PopupMenuButton(
                                icon: Text(''),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  PopupMenuItem(
                                    value: 'photo',
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: ListTile(
                                        leading: Icon(Icons.photo),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'video',
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: ListTile(
                                        leading: Icon(Icons.video_call),
                                      ),
                                    ),
                                  ),
                                ],
                                onSelected: (selectedValue) {
                                  if (selectedValue != null) {
                                    // Handle the selected value
                                    if (selectedValue == 'photo') {
                                      // Handle photo selection
                                      pickImageViaCamera();
                                    } else if (selectedValue == 'video') {
                                      // Handle video selection
                                      pickVideoViaCamera();
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            // Handle lightbulb icon tapped
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LightbulbPage()),
                              );
                            });
                          },
                          child: Icon(
                            Icons.lightbulb,
                            color: Color(0xFF3797D0),
                          ),
                        ),
                        InkWell(
                          onTap: () async{
                            // Handle person icon tapped
                            if (signedIn){
                              bool right = emails_of_admins.contains( await getUserEmail());
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => right? AdminProfilePage():ProfilePage()),
                                );
                              });
                            } else {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              });
                            }
                          },
                          child: Icon(
                            SignInIcon.icon,
                            color: Color(0xFF3797D0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(),),
            backgroundColor: Color.fromARGB(255, 27, 25, 26),
          );
        }
      },
    );
  }
}

late String? saveEmail;
late int? ID_of_user;
    Future<void> requestPermissions() async {
    // Request storage permission
    var status = await Permission.storage.request();
    print('Storage permission status: $status');

    // Request camera permission
    status = await Permission.camera.request();
    print('Camera permission status: $status');

    // Request location permission
    status = await Permission.location.request();
    print('Location permission status: $status');
    permissionGranted = true;

  }

Future<bool> checkUserLoggedIn() async {
  await requestPermissions();
  String? userToken = await getUserToken();
  saveEmail = await getUserEmail();
  return userToken != null;
}

// Storing the user token
Future<void> storeUserToken(String token) async {
  await storage.write(key: 'userToken', value: token);
}

// Retrieving the user token
Future<String?> getUserToken() async {
  return await storage.read(key: 'userToken');
}

// Removing the user token
Future<void> removeUserToken() async {
  SignInIcon = Icon(Icons.login);
  await storage.delete(key: 'userToken');
}

// Storing the user email
Future<void> storeUserEmail(String email) async {
  await storage.write(key: 'userEmail', value: email);
}

// Retrieving the user email
Future<String?> getUserEmail() async {
  return await storage.read(key: 'userEmail');
}

// Removing the user email
Future<void> removeUserEmail() async {
  await storage.delete(key: 'userEmail');
}

// Storing the user id
Future<void> storeUserId(String userid) async {
  await storage.write(key: 'id', value: userid);
}

// Retrieving the user id
Future<String?> getUserid() async {
  return await storage.read(key: 'id');
}

// Removing the user email
Future<void> removeUserId() async {
  await storage.delete(key: 'id');
}
