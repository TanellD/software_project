import 'package:flutter/material.dart';
import 'package:software_project/main.dart';
import 'package:software_project/person_account.dart';
import 'package:software_project/sign_up_new.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String emailError = "Add email";
String passwordError = "Add password";

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password_one = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordOneLocked = true;
  bool passwordTwoLocked = true;
  double signinWidth = 105;
  double signinHeight = 36;
  Color signinColor = Color(0xFF3797D0).withOpacity(0.85);
  Widget signinWidget = Text(
    "Sign in",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  );
  bool credentials = true;
  void goBack() {
    Navigator.pop(context); // Go back to the previous page
  }

  Widget buildHeaderContainer(
    double top,
    double left,
    double width,
    double height,
    Color color,
    Widget child,
  ) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading
        ? Scaffold(
          backgroundColor: Color(0xFFEBF4FA),
          body: Center(
              child: CircularProgressIndicator(),
            ),
        )
        :Scaffold(
      backgroundColor: Color(0xFFEBF4FA),
      body: Stack(
        children: [
          Positioned(
            top: -115,
            right: -30,
            child: Container(
              width: 310,
              height: 290,
              decoration: BoxDecoration(
                color: Color(0xFF3797D0),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -60,
            left: -25,
            child: Container(
              width: 200,
              height: 180,
              decoration: BoxDecoration(
                color: Color(0xFF9EDBFF),
                shape: BoxShape.circle,
              ),
              child: Container(
                alignment: AlignmentDirectional(-0.5, 0.1),
                child: InkWell(
                  onTap: goBack,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 75,
              child: Padding(
                padding: const EdgeInsets.only(top: 130),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xFF9EDBFF),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 90,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                          decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
                          /*height: 250,*/ width: 250,
                          child: Column(
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(height: 20),
                                      TextFormField(
                                        controller: _login,
                                        validator: (value) {
                                          // Add validation rule for the first form field
                                          if (value == null || value.isEmpty) {
                                            return ' ${emailError}';
                                          }
                                          // Add more specific validation rules for the first form field

                                          return null; // Return null if the validation passes
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          hintText: 'e-mail',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF000000)
                                                .withOpacity(0.24),
                                            fontSize: 15,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEBEBEB))),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        obscureText: passwordOneLocked,
                                        controller: _password_one,
                                        validator: (value) {
                                          // Add validation rule for the first form field
                                          if (value == null || value.isEmpty) {
                                            return 'Type password';
                                          }
                                          // Add more specific validation rules for the first form field

                                          return null; // Return null if the validation passes
                                        },
                                        decoration: InputDecoration(
                                          // prefix: SizedBox(width: 45),
                                          prefixIcon: IconButton(
                                            icon: Icon(passwordOneLocked
                                                ? Icons.lock
                                                : Icons.lock_open),
                                            onPressed: () {
                                              setState(() {
                                                passwordOneLocked =
                                                    !passwordOneLocked;
                                              });
                                            },
                                          ),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF000000)
                                                .withOpacity(0.24),
                                            fontSize: 15,
                                          ),
                                          //border: InputBorder.none,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEBEBEB))),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ))
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      height: signinHeight,
                      width: signinWidth,
                      decoration: BoxDecoration(
                        color: signinColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        onTap: () async {
                          signinWidth = 60;
                          signinHeight = 40;
                          if (_formKey.currentState!.validate()) {
                            if (credentials) {
                              signinWidget = Icon(Icons.check_circle_outline);
                              if (!_login.text.contains('@') ||
                                  !_login.text.contains('.')) {
                                emailError = "Invalid email format";
                                _login.clear();
                                _formKey.currentState!.validate();
                              } else {
                                isLoading = true;
                                String pass = await loginUser(
                                    _login.text, _password_one.text);
                                print("Got here");
                                isLoading = false;
                                if (pass != "failed") {
                                  isLoading = true;
                                  if (await fetchUser(_login.text, pass)) {
                                    await storeUserToken(pass);
                                    await storeUserEmail(_login.text);
                                    signedIn = true;
                                    isLoading = false;
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (route) => false,
                                    );
                                  } else {
                                    signinColor = Colors.red;
                                    emailError = "Invalid email format";
                                    _login.clear();
                                    _formKey.currentState!.validate();
                                  }
                                } else {
                                  signinColor = Colors.red;
                                  emailError = "Email not registered";
                                  _login.clear();
                                  _formKey.currentState!.validate();
                                }
                              }
                            } else {
                              signinColor = Colors.red;
                              emailError = "Invalid email format";
                              _login.clear();
                              _formKey.currentState!.validate();
                            }
                          }
                          setState(() {
                            signinWidget = Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          });
                        },
                        child: Center(child: signinWidget),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account: ",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            });
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.facebook_rounded,
                    //       color: Colors.blue,
                    //       size: 46,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Container(
                    //         width: 36,
                    //         height: 36,
                    //         child: Image(
                    //           image: AssetImage('lib/icons/google.png'),
                    //         )),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Container(
                    //         width: 42,
                    //         height: 42,
                    //         child: Image(
                    //           image: AssetImage('lib/icons/vk.png'),
                    //         )),
                    //   ],
                    // )
                  ],
                ),
              ))
        ],
      ),
      
    );
  }
}

Widget con() {
  return Container(
    width: 23,
    height: 23,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
    ),
    child: Icon(
      Icons.cancel,
      color: Colors.red,
      size: 24,
    ),
  );
}

Future<String> loginUser(String email, String password) async {
  var url = Uri.parse('https://paveltrty.pythonanywhere.com/auth/token/login');

  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'password': password,
      'username': email.substring(0, email.indexOf('@'))
    }),
  );

  signedPerson.user_name = email.substring(0, email.indexOf('@'));
  signedPerson.user_email = email;

  if (response.statusCode == 200) {
    // Login successful, extract and return the auth token
    var jsonResponse = jsonDecode(response.body);
    String authToken = jsonResponse['auth_token'];
    // Store the user token securely
      print('Response body:  1 //////    ${response.body}');
      print('User: ${jsonResponse.toString()}');
    return authToken;
  } else {
    // Login failed, handle accordingly
    print('Login failed. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return "failed";
  }
}

Future<bool> fetchUser(String email, String authToken) async {
  var url = Uri.parse(
      'https://paveltrty.pythonanywhere.com/api/v1/auth/users/?email=$email');

  var response = await http.get(
    url,
    headers: {'Authorization': 'Token $authToken'},
  );

  if (response.statusCode == 200) {
    // User retrieved successfully
    var jsonResponse = jsonDecode(response.body);
    print('Response body:  2 //////    ${response.body}');
    print('User: ${jsonResponse.toString()}');
  } else {
    // Error occurred, handle accordingly
    print('Error retrieving user. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return false;
  }
  return true;
}
