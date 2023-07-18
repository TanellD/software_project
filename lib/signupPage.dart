// import 'package:flutter/material.dart';
// import 'package:software_project/loginPage.dart';
// import 'package:software_project/main.dart';
// void main() => runApp(MyApp());

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class MyApp extends StatelessWidget{
//   build(context){
//     return MaterialApp(home: SignupPage(),);
//   }
// }

// class _SignupPageState extends State<SignupPage> {
//   final TextEditingController _login = TextEditingController();
//   final TextEditingController _password_one = TextEditingController();
//   final TextEditingController _password_two = TextEditingController();
//   double signinWidth = 105;
//   double signinHeight = 36;
//   Color signinColor = Color(0xFF3797D0).withOpacity(0.85);
//   Widget signinWidget = Text(
//     "Sign up",
//     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//   );
//   bool credentials = true;
//   void goBack() {
//     Navigator.pop(context); // Go back to the previous page
//   }

//   Widget buildHeaderContainer(
//     double top,
//     double left,
//     double width,
//     double height,
//     Color color,
//     Widget child,
//   ) {
//     return Positioned(
//       top: top,
//       left: left,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//         child: child,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEBF4FA),
//       body: Stack(
//         children: [
//           Positioned(
//             top: -115,
//             right: -30,
//             child: Container(
//               width: 310,
//               height: 290,
//               decoration: BoxDecoration(
//                 color: Color(0xFF3797D0),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             top: -60,
//             left: -25,
//             child: Container(
//               width: 200,
//               height: 180,
//               decoration: BoxDecoration(
//                 color: Color(0xFF9EDBFF),
//                 shape: BoxShape.circle,
//               ),
//               child: Container(
//                 alignment: AlignmentDirectional(-0.5, 0.1),
//                 child: InkWell(
//                   onTap: goBack,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_back),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//               left: 110,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 130),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                           color: Color(0xFF9EDBFF),
//                           borderRadius: BorderRadius.circular(30)),
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                         size: 90,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     //--------------------------
//                     //ValueListenableBuilder(valueListenable: [_login, _password_one, _password_two],),
//                     Container(
//                       height: 36,
//                       width: 205,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: TextField(
//                           controller: _login,
//                           decoration: InputDecoration(
//                             hintText: 'E-mail or Phone number',
//                             hintStyle: TextStyle(
//                               color: Color(0xFF000000).withOpacity(0.24),
//                               fontSize: 15,
//                             ),
//                             border: InputBorder.none,
//                           ),
//                           onTap: () {
//                             setState(() {});
//                             // Handle text field tap if needed
//                           },
//                           onSubmitted: (String value) {
//                             setState(() {});
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 36,
//                       width: 205,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 16.0),
//                           child: TextField(
//                             controller: _password_one,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintText: 'Password',
                              
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF000000).withOpacity(0.24),
//                                 fontSize: 15,
//                               ),
//                               border: InputBorder.none,
//                             ),
//                             onTap: () {
//                               setState(() {});
//                               // Handle text field tap if needed
//                             },
//                             onSubmitted: (String value) {
//                               setState(() {});
//                             },
//                           ),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 36,
//                       width: 205,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 16.0),
//                           child: TextField(
//                             controller: _password_two,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintText: 'Confirm Password',
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF000000).withOpacity(0.24),
//                                 fontSize: 15,
//                               ),
//                               border: InputBorder.none,
//                             ),
//                             onTap: () {
//                               setState(() {});
//                               // Handle text field tap if needed
//                             },
//                             onSubmitted: (String value) {
//                               setState(() {});
//                             },
//                           ),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),

//                     //-------------------------------
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: signinHeight,
//                       width: signinWidth,
//                       child: Center(
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               signinWidth = 60;
//                               signinHeight = 40;
//                               if (credentials) {
//                                 signinWidget = Icon(Icons.check_circle_outline);
//                               } else {
//                                 signinColor = Colors.red;
//                                 signinWidget = Container(
//                                   width: 23,
//                                   height: 23,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                   ),
//                                   child: Icon(
//                                     Icons.cancel,
//                                     color: Colors.red,
//                                     size: 24,
//                                   ),
//                                 );
//                               }
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignupCodePage()),
//                               );
//                             });
//                           },
//                           child: signinWidget,
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: signinColor,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Already have an account: ",
//                           style: TextStyle(fontSize: 12, color: Colors.black),
//                         ),
//                         Container(
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 goBack();
//                               });
//                             },
//                             child: Container(
//                               child: Text(
//                                 "Sign in",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12,
//                                     color: Colors.blue),
//                               ),
//                             ),
//                           ),
                          
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.facebook_rounded,
//                           color: Colors.blue,
//                           size: 46,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                             width: 36,
//                             height: 36,
//                             child: Image(
//                               image: AssetImage('lib/icons/google.png'),
//                             )),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                             width: 42,
//                             height: 42,
//                             child: Image(
//                               image: AssetImage('lib/icons/vk.png'),
//                             )),
//                       ],
//                     )
//                   ],
//                 ),
//               ))
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Color(0xFF9EDBFF),
//         child: Container(
//           height: 40,
//         ),
//       ),
//     );
//   }
// }

// class SignupCodePage extends StatefulWidget {
//   @override
//   _SignupCodePageState createState() => _SignupCodePageState();
// }

// class _SignupCodePageState extends State<SignupCodePage> {
//   double signupCodePageWidth = 105;
//   double signupCodePageHeight = 36;
//   Color signupCodePageColor = Color(0xFF3797D0).withOpacity(0.85);
//   bool signupCodePageVerifiedCode = true;
//   Widget signupCodePageWidget = Text(
//     "Sign up",
//     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//   );

//   void goBack() {
//     Navigator.pop(context); // Go back to the previous page
//   }

//   Widget buildHeaderContainer(
//     double top,
//     double left,
//     double width,
//     double height,
//     Color color,
//     Widget child,
//   ) {
//     return Positioned(
//       top: top,
//       left: left,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//         child: child,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEBF4FA),
//       body: Stack(
//         children: [
//           Positioned(
//             top: -115,
//             right: -30,
//             child: Container(
//               width: 310,
//               height: 290,
//               decoration: BoxDecoration(
//                 color: Color(0xFF3797D0),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             top: -60,
//             left: -25,
//             child: Container(
//               width: 200,
//               height: 180,
//               decoration: BoxDecoration(
//                 color: Color(0xFF9EDBFF),
//                 shape: BoxShape.circle,
//               ),
//               child: Container(
//                 alignment: AlignmentDirectional(-0.5, 0.1),
//                 child: InkWell(
//                   onTap: goBack,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_back),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//               left: 110,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 100),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                           color: Color(0xFF9EDBFF),
//                           borderRadius: BorderRadius.circular(30)),
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                         size: 90,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                       height: 36,
//                       width: 205,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'E-mail or Phone number',
//                             hintStyle: TextStyle(
//                               color: Color(0xFF000000).withOpacity(0.24),
//                               fontSize: 15,
//                             ),
//                             border: InputBorder.none,
//                           ),
//                           onTap: () {
//                             setState(() {});
//                             // Handle text field tap if needed
//                           },
//                           onSubmitted: (String value) {
//                             setState(() {});
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 36,
//                       width: 205,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 16.0),
//                           child: TextField(
                            
//                             decoration: InputDecoration(
//                               hintText: 'Password',
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF000000).withOpacity(0.24),
//                                 fontSize: 15,
//                               ),
//                               border: InputBorder.none,
//                             ),
//                             onTap: () {
//                               setState(() {});
//                               // Handle text field tap if needed
//                             },
//                             onSubmitted: (String value) {
//                               setState(() {});
//                             },
//                           ),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 36,
//                       width: 150,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 16.0),
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Confirmation code',
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF000000).withOpacity(0.24),
//                                 fontSize: 15,
//                               ),
//                               border: InputBorder.none,
//                             ),
//                             onTap: () {
//                               setState(() {});
//                               // Handle text field tap if needed
//                             },
//                             onSubmitted: (String value) {
//                               setState(() {});
//                             },
//                           ),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 60,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Already have an account: ",
//                           style: TextStyle(fontSize: 12, color: Colors.black),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               Navigator.pop(
//                                 context
//                               );
//                             });
//                           },
//                           child: Text(
//                             "Sign in",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                                 color: Colors.blue),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.facebook_rounded,
//                           color: Colors.blue,
//                           size: 46,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                             width: 36,
//                             height: 36,
//                             child: Image(
//                               image: AssetImage('lib/icons/google.png'),
//                             )),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                             width: 42,
//                             height: 42,
//                             child: Image(
//                               image: AssetImage('lib/icons/vk.png'),
//                             )),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 50),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 signupCodePageHeight = 40;
//                                 signupCodePageWidth = 60;
//                                 if (signupCodePageVerifiedCode) {
//                                   signedIn = true;
//                                   signupCodePageWidget =
//                                       Icon(Icons.check_circle_outline);
//                                   Navigator.pushAndRemoveUntil(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => AboutSelf()),
//                                     (route) => false,
//                                   );
//                                 } else {
//                                   signupCodePageColor = Colors.red;
//                                   signupCodePageWidget = Container(
//                                     width: 23,
//                                     height: 23,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.white,
//                                     ),
//                                     child: Icon(
//                                       Icons.cancel,
//                                       color: Colors.red,
//                                       size: 24,
//                                     ),
//                                   );
//                                 }
//                               });
//                             },
//                             child: Container(
//                               width: 105,
//                               height: 26,
//                               child: Center(
//                                 child: Text(
//                                   "Send",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF9EDBFF),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "10:00",
//                               style: TextStyle(color: Color(0xFF3797D0)),
//                             ),
//                             Icon(
//                               Icons.timer_rounded,
//                               color: Color(0xFF3797D0),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ))
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Color(0xFF9EDBFF),
//         child: Container(
//           height: 40,
//         ),
//       ),
//     );
//   }
// }

// //
// //
// //
// //
// //
// //
// //
// //
// //




// class AboutSelf extends StatefulWidget {
//   const AboutSelf({super.key});

//   @override
//   State<AboutSelf> createState() => _AboutSelfState();
// }

// class _AboutSelfState extends State<AboutSelf> {
//   double signupCodePageWidth = 105;
//   double signupCodePageHeight = 36;
//   Color signupCodePageColor = Color(0xFF3797D0).withOpacity(0.85);
//   bool signupCodePageVerifiedCode = true;
//   Widget signupCodePageWidget = Text(
//     "Sign up",
//     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//   );

//   void goBack() {
//     Navigator.pop(context); // Go back to the previous page
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEBF4FA),
//       body: Stack(
//         children: [
//           Positioned(
//             top: -115,
//             right: -30,
//             child: Container(
//               width: 310,
//               height: 290,
//               decoration: BoxDecoration(
//                 color: Color(0xFF3797D0),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             top: -60,
//             left: -25,
//             child: Container(
//               width: 200,
//               height: 180,
//               decoration: BoxDecoration(
//                 color: Color(0xFF9EDBFF),
//                 shape: BoxShape.circle,
//               ),
//               child: Container(
//                 alignment: AlignmentDirectional(-0.5, 0.1),
//                 child: InkWell(
//                   onTap: goBack,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_back),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 130),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Tell us more about yourself",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 24),
//                       ),
//                     ),
//                     SizedBox(height: 15,),
//                     Container(
//                       height: 40,
//                       width: 300,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Icon(Icons.person,color: Color(0xFF2F88FF).withOpacity(0.3),),
//                           ),
//                           Text(
//                             '|',
//                             style: TextStyle(
//                               color: Color(0xFF000000).withOpacity(0.24),
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Full name',
//                                   hintStyle: TextStyle(
//                                     color: Color(0xFF000000).withOpacity(0.24),
//                                     fontSize: 15,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                                 onTap: () {
//                                   setState(() {});
//                                   // Handle text field tap if needed
//                                 },
//                                 onSubmitted: (String value) {
//                                   setState(() {});
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 40,
//                       width: 300,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Icon(Icons.calendar_today,color: Color(0xFF2F88FF).withOpacity(0.3),),
//                           ),
//                           Text(
//                             '|',
//                             style: TextStyle(
//                               color: Color(0xFF000000).withOpacity(0.24),
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Date of Birth',
//                                   hintStyle: TextStyle(
//                                     color: Color(0xFF000000).withOpacity(0.24),
//                                     fontSize: 15,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                                 onTap: () {
//                                   setState(() {});
//                                   // Handle text field tap if needed
//                                 },
//                                 onSubmitted: (String value) {
//                                   setState(() {});
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 40,
//                       width: 300,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Icon(Icons.male,color: Color(0xFF2F88FF).withOpacity(0.3),),
//                           ),
//                           Text(
//                             '|',
//                             style: TextStyle(
//                               color: Color(0xFF000000).withOpacity(0.24),
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Gender',
//                                   hintStyle: TextStyle(
//                                     color: Color(0xFF000000).withOpacity(0.24),
//                                     fontSize: 15,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                                 onTap: () {
//                                   setState(() {});
//                                   // Handle text field tap if needed
//                                 },
//                                 onSubmitted: (String value) {
//                                   setState(() {});
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 40,
//                       width: 300,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE8DFDF).withOpacity(0.85),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Icon(Icons.flag,color: Color(0xFF2F88FF).withOpacity(0.3),),
//                           ),
//                           Text(
//                             '|',
//                             style: TextStyle(
//                               color: Color(0xFF000000).withOpacity(0.24),
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Nationality',
//                                   hintStyle: TextStyle(
//                                     color: Color(0xFF000000).withOpacity(0.24),
//                                     fontSize: 15,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                                 onTap: () {
//                                   setState(() {});
//                                   // Handle text field tap if needed
//                                 },
//                                 onSubmitted: (String value) {
//                                   setState(() {});
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 150,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           signupCodePageHeight = 40;
//                           signupCodePageWidth = 60;
//                           if (signupCodePageVerifiedCode) {
//                             signedIn = true;
//                             signupCodePageWidget =
//                                 Icon(Icons.check_circle_outline);
//                             Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => HomePage()),
//                               (route) => false,
//                             );
//                           } else {
//                             signupCodePageColor = Colors.red;
//                             signupCodePageWidget = Container(
//                               width: 23,
//                               height: 23,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white,
//                               ),
//                               child: Icon(
//                                 Icons.cancel,
//                                 color: Colors.red,
//                                 size: 24,
//                               ),
//                             );
//                           }
//                         });
//                       },
//                       child: Container(
//                         width: 105,
//                         height: 26,
//                         child: Center(
//                           child: Text(
//                             "Submit",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF9EDBFF),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//               )
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Color(0xFF9EDBFF),
//         child: Container(
//           height: 40,
//         ),
//       ),
//     );
//   }
// }
