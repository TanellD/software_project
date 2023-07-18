import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:software_project/loginPage.dart';
import 'package:software_project/main.dart';
import 'package:software_project/person_account.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:core';

//import 'package:firebase_auth/firebase_auth.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutSelf(),
    );
  }
}

SignedPersonAccount signedPerson = SignedPersonAccount(
  user_name: '',
  trusted: false,
  user_photo: '',
  user_email: '',
  user_password: '',
);
late String logintext;
String loginpass = "";
Widget signinWidget = Text(
  "Sign up",
  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
);

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

bool yes = false;
String? code;


class _SignupPageState extends State<SignupPage> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password_one = TextEditingController();
  final TextEditingController _password_two = TextEditingController();
  bool passwordOneLocked = true;
  bool passwordTwoLocked = true;

  final _formKey = GlobalKey<FormState>();
  double signinWidth = 105;
  double signinHeight = 36;
  Color signinColor = Color(0xFF3797D0).withOpacity(0.85);

  bool credentials = true;
  void goBack() {
    Navigator.pop(context); // Go back to the previous page
  }

bool _isPasswordStrongEnough(String password) {
  // Implement your password strength criteria here
  // For example, check if the password contains at least 8 characters and a combination of letters, numbers, and symbols
  final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&()])[A-Za-z\d@$!%*#?&()]{8,}$');
  return passwordRegex.hasMatch(password);
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
    signinWidget = Text(
      "Sign up",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
    return isLoading
        ? Scaffold(
          backgroundColor: Color(0xFFEBF4FA),
          body: Center(
              child: CircularProgressIndicator(),
            ),
        )
        : Scaffold(
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
                          //--------------------------
                          //ValueListenableBuilder(valueListenable: [_login, _password_one, _password_two],),

                          Center(
                            child: Container(
                                decoration:
                                    BoxDecoration(color: Color(0xFFF9F9F9)),
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
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '${emailError}';
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
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFEBEBEB))),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            TextFormField(
                                              obscureText: passwordOneLocked,
                                              controller: _password_one,
                                              validator: (value) {
                                                // Add validation rule for the first form field
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '${passwordError}';
                                                } else if (value.length < 6) {
                                                  return 'Make password longer';
                                                } else if (yes) {
                                                  return '${passwordError}';
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
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFEBEBEB))),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            TextFormField(
                                              obscureText: passwordTwoLocked,
                                              decoration: InputDecoration(
                                                prefixIcon: IconButton(
                                                  icon: passwordTwoLocked
                                                      ? Icon(Icons.lock)
                                                      : Icon(Icons.lock_open),
                                                  onPressed: () {
                                                    setState(() {
                                                      passwordTwoLocked =
                                                          !passwordTwoLocked;
                                                    });
                                                  },
                                                ),
                                                hintText: 'Confirm Password',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.24),
                                                  fontSize: 15,
                                                ),
                                                //border: InputBorder.none,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFEBEBEB))),
                                              ),
                                              controller: _password_two,
                                              validator: (value) {
                                                // Add validation rule for the first form field
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  print(
                                                      "my password ${_password_two}");
                                                  return '${passwordError}';
                                                } else if (value !=
                                                    _password_one.text) {
                                                  return 'Passwords don\'t match';
                                                } else if (yes) {
                                                  return '${passwordError}';
                                                }
                                                // Add more specific validation rules for the first form field

                                                return null; // Return null if the validation passes
                                              },
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ))
                                  ],
                                )),
                          ),

                          //-------------------------------
                          SizedBox(
                            height: 30,
                          ),

                          Container(
                            height: signinHeight,
                            width: signinWidth,
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  yes = false;
                                  if (_formKey.currentState!.validate()) {
                                    // Validate all input fields
                                    if (!_login.text.contains('@') ||
                                        !_login.text.contains('.')) {
                                      emailError = "Invalid email format";
                                      _login.clear();
                                      _formKey.currentState!.validate();
                                    } else if(!_isPasswordStrongEnough(_password_one.text)){
                                      print(_password_one.text);
                                      setState(() {
                                        passwordError = " password must contains at least 8 characters,\nwhich include letters, numbers, and symbols";
                                      });
                                      _password_one.clear();
                                      _password_two.clear();
                                      _formKey.currentState!.validate();
                                    } else {
                                      print(_login.text.substring(
                                          0, _login.text.indexOf('@')));
                                      print(_login.text);
                                      print(_password_one.text);
                                      signedPerson = SignedPersonAccount(
                                        user_name: _login.text.substring(
                                            0, _login.text.indexOf('@')),
                                        user_email: _login.text,
                                        user_password: _password_one.text,
                                      );
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (await createUser(signedPerson)) {
                                        code = await sendVerificationCode(
                                            signedPerson.user_email.toString());
                                        signinWidget = Text(
                                          "Confirm",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                        _secondsRemaining = 120;
                                        isLoading =
                                            false; //////////////////////////////////////////////////////////////////
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignupCodePage(
                                              context: context,
                                              params: [
                                                _login.text,
                                                _password_one.text
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        yes = true;
                                        if (requestVerfication
                                            .contains("similar")) {
                                          passwordError =
                                              "Your password can’t be too similar to your other personal information";
                                          setState(() {});
                                          _formKey.currentState!.validate();
                                        } else if (requestVerfication
                                            .contains("characters")) {
                                          passwordError =
                                              "Your password must contain at least 8 characters";
                                          setState(() {});
                                          _formKey.currentState!.validate();
                                        }
                                      }
                                    }
                                  }
                                  setState(() {});
                                },
                                child: signinWidget,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: signinColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Already have an account: ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    goBack();
                                  });
                                },
                                child: Text(
                                  "Sign in",
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

bool isLoading = false;

class SignupCodePage extends StatefulWidget {
  // Track the loading state
  List<String?> params;
  BuildContext context;
  SignupCodePage({required this.context, required this.params});
  @override
  _SignupCodePageState createState() =>
      _SignupCodePageState(context: context, params: params);
}

class _SignupCodePageState extends State<SignupCodePage> {
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();

  double signinWidth = 105;
  double signinHeight = 36;
  Color signinColor = Color(0xFF3797D0).withOpacity(0.85);
  bool passwordOneLocked = true;
  List<String?> params;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _code = TextEditingController();
  BuildContext context;
  _SignupCodePageState({required this.context, required this.params}) {
    _login = TextEditingController(text: params[0]);
    _password = TextEditingController(text: params[1]);
  }
  double signupCodePageWidth = 105;
  double signupCodePageHeight = 36;
  Color signupCodePageColor = Color(0xFF3797D0).withOpacity(0.85);
  bool signupCodePageVerifiedCode = true;
  Widget signupCodePageWidget = Text(
    "Sign up",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  );

  void gogoBack() async {
    await deleteUser(_login.text, _password.text); // Delete the user first
    if (mounted) {
      setState(() {
        signinWidget = Text("Sign up"); // Update the signinWidget
      });
    }
    Navigator.pop(
        context); // Use the saved ancestorContext to go back to the previous page
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
    return isLoading
        ? Scaffold(
          backgroundColor: Color(0xFFEBF4FA),
          body: Center(
              child: CircularProgressIndicator(),
            ),
        )
        : Scaffold(
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
                          //--------------------------
                          //ValueListenableBuilder(valueListenable: [_login, _password_one, _password_two],),

                          Center(
                            child: Container(
                                decoration:
                                    BoxDecoration(color: Color(0xFFF9F9F9)),
                                /*height: 250,*/ width: 250,
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height: 20),
                                        TextField(
                                          readOnly: true,
                                          controller: _login,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.person),
                                            hintText: 'E-mail',
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
                                        TextField(
                                          readOnly: true,
                                          obscureText: passwordOneLocked,
                                          controller: TextEditingController(
                                              text: params[1]),
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
                                        Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            controller: _code,
                                            validator: (value) {
                                              // Add validation rule for the first form field
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Type the code';
                                              }
                                              // Add more specific validation rules for the first form field

                                              return null; // Return null if the validation passes
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.person),
                                              hintText:
                                                  'Code sent to your email',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.24),
                                                fontSize: 15,
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFFEBEBEB))),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    )
                                  ],
                                )),
                          ),

                          //-------------------------------
                          SizedBox(
                            height: 30,
                          ),

                          Column(
                            children: [
                              Container(
                                height: signinHeight,
                                width: signinWidth,
                                child: Center(
                                  child: InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_code.text.toString() ==
                                            code?.substring(1, 5)) {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          await storeUserToken(await loginUser(
                                              _login.text, _password.text));
                                          await storeUserEmail(_login.text);
                                          isLoading = false; ///////////////////
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AboutSelf()),
                                            (route) => false,
                                          );
                                        } else {
                                          setState(() {
                                            signinWidget = Text(
                                                "Wrong code"); // Update the signinWidget
                                          });
                                        }
                                      }
                                    },
                                    child: signinWidget,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: signinColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              CountdownTimerWidget(
                                loginText: _login.text,
                                passwordText: _password.text.toString(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Already have an account: ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              InkWell(
                                onTap: () async {
                                  int count = 0;
                                  await deleteUser(_login.text, _password.text);
                                  Navigator.popUntil(context, (route) {
                                    return count++ == 2;
                                  });

                                  setState(() {});
                                },
                                child: Text(
                                  "Sign in",
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

class CountdownTimerWidget extends StatefulWidget {
  final String loginText;
  final String passwordText;

  CountdownTimerWidget({required this.loginText, required this.passwordText});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

int _secondsRemaining = 120;

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void gogoBack(String loginText, String passwordText) async {
    setState(() {
      isLoading = true;
    });
    await deleteUser(loginText, passwordText); // Delete the user first
    if (mounted) {
      setState(() {
        signinWidget = Text("Sign up"); // Update the signinWidget
      });
    }
    Navigator.pop(context); // Go back to the previous page
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        gogoBack(widget.loginText,
            widget.passwordText); // Call gogoBack() method with parameters
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        '${formatTime(_secondsRemaining)}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

//
//
//
//
//
//
//
//
//

class AboutSelf extends StatefulWidget {
  const AboutSelf({super.key});

  @override
  State<AboutSelf> createState() => _AboutSelfState();
}

Widget signupCodePageWidget = Text(
  "Sign up",
  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
);

class _AboutSelfState extends State<AboutSelf> {
  double signupCodePageWidth = 105;
  double signupCodePageHeight = 36;
  Color signupCodePageColor = Color(0xFF3797D0).withOpacity(0.85);
  bool signupCodePageVerifiedCode = true;

  void goBack() {
    Navigator.pop(context); // Go back to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFEBF4FA),
      body: SingleChildScrollView(
        child: Stack(
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
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 130),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tell us more about yourself",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DFDF).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFF2F88FF).withOpacity(0.3),
                              ),
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                color: Color(0xFF000000).withOpacity(0.24),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Full name',
                                    hintStyle: TextStyle(
                                      color:
                                          Color(0xFF000000).withOpacity(0.24),
                                      fontSize: 15,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onTap: () {
                                    setState(() {});
                                    // Handle text field tap if needed
                                  },
                                  onSubmitted: (String value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DFDF).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.calendar_today,
                                color: Color(0xFF2F88FF).withOpacity(0.3),
                              ),
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                color: Color(0xFF000000).withOpacity(0.24),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Date of Birth',
                                    hintStyle: TextStyle(
                                      color:
                                          Color(0xFF000000).withOpacity(0.24),
                                      fontSize: 15,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onTap: () {
                                    setState(() {});
                                    // Handle text field tap if needed
                                  },
                                  onSubmitted: (String value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DFDF).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.male,
                                color: Color(0xFF2F88FF).withOpacity(0.3),
                              ),
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                color: Color(0xFF000000).withOpacity(0.24),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Gender',
                                    hintStyle: TextStyle(
                                      color:
                                          Color(0xFF000000).withOpacity(0.24),
                                      fontSize: 15,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onTap: () {
                                    setState(() {});
                                    // Handle text field tap if needed
                                  },
                                  onSubmitted: (String value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DFDF).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.flag,
                                color: Color(0xFF2F88FF).withOpacity(0.3),
                              ),
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                color: Color(0xFF000000).withOpacity(0.24),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Nationality',
                                    hintStyle: TextStyle(
                                      color:
                                          Color(0xFF000000).withOpacity(0.24),
                                      fontSize: 15,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onTap: () {
                                    setState(() {});
                                    // Handle text field tap if needed
                                  },
                                  onSubmitted: (String value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            signupCodePageHeight = 40;
                            signupCodePageWidth = 60;
                            if (signupCodePageVerifiedCode) {
                              signedIn = true;
                              signupCodePageWidget =
                                  Icon(Icons.check_circle_outline);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false,
                              );
                            } else {
                              signupCodePageColor = Colors.red;
                              signupCodePageWidget = Container(
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
                          });
                        },
                        child: Container(
                          width: 105,
                          height: 26,
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF9EDBFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      
    );
  }
}

String requestVerfication = "";

Future<bool> createUser(SignedPersonAccount user) async {
  await Future.delayed(Duration(seconds: 1), () {});
  var requestBody = {
    'email': user.user_email,
    'username': user.user_name,
    'password': user.user_password,
  };

  String userinfo = jsonEncode(requestBody);
  print(userinfo);
  try {
    http.Response responsePost = await http.post(
      Uri.parse("https://paveltrty.pythonanywhere.com/api/v1/auth/users/"),
      headers: {'Content-Type': 'application/json'},
      body: userinfo,
    );
    requestVerfication = responsePost.body.toString();
    print("what was returned : ${requestVerfication}");
    if (responsePost.statusCode == 200 || responsePost.statusCode == 201) {
      print("Request successful");
    } else {
      print('Request failed with status code ${responsePost.statusCode}');
      return false;
    }
  } catch (e) {
    print('Exception: $e');
    return false;
  }

  return true;
}

Future<bool> deleteUser(String email, String password) async {
  final url =
      Uri.parse("https://paveltrty.pythonanywhere.com/api/v1/auth/users/me/");
  final usernameToDelete = email.substring(0, email.indexOf('@'));
  final authToken = await loginUser(email, password);
  if (authToken != "failed") {
    try {
      final response = await http.delete(
        url.replace(queryParameters: {'username': usernameToDelete}),
        headers: {
          'Authorization': 'Token $authToken',
        },
        body: {
          'current_password':
              password, // Include the current_password in the request body
        },
      );

      if (response.statusCode == 204) {
        print('User deleted successfully.');
        return true;
      } else {
        print('Failed to delete user. Status code: ${response.statusCode}');
        print("Response error: ${response.body}");
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  return false;
}

Future<String> sendVerificationCode(String email) async {
  final String apiUrl =
      'https://paveltrty.pythonanywhere.com/api/approvingMail/';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, String> body = {
    'email': '$email',
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Verification code sent successfully');
      return response.body;
    } else {
      print('Failed to send verification code');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error sending verification code: $error');
  }
  return "failed";
}
