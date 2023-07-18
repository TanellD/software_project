import 'package:flutter/material.dart';
import 'package:software_project/addNewLocationPage.dart';
import 'package:software_project/main.dart';
import 'package:software_project/person_account.dart';
import 'package:software_project/settingPage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:software_project/sign_up_new.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String? profileName = signedPerson.user_name;
  late String? profileEmail = signedPerson.user_email;
  bool confirmLogout = false;
  bool imageVisible = true;
  File? _image;

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
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Color(0xFFEBF4FA),
                  borderRadius: BorderRadius.circular(30)),
              )
          ],
        ),
      ),
    );
  }
}
