import 'package:geolocator/geolocator.dart';



class User{
  static bool signed = false;
  static bool gotGeoPermission = false;
  static late Position position;
}

class SignedPersonAccount extends User {
  String user_name = '';
  int user_id = 0;
  String? user_photo;
  String user_email = '';
  bool? trusted = false;
  String user_password;

  SignedPersonAccount({
    required this.user_email,
    this.trusted,
    required this.user_name,
    this.user_photo,
    required this.user_password,
  });
}
