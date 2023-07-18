import 'dart:convert';

import 'package:http/http.dart'; //as http;
class NewPLace{
  late List<String?> images;
  late double Distance;
  late String Name;
  late String Description;
  String Owner = "System";
  late int rating;
  late int votesNum;
  late String Tags;
  late bool Is_Approved;
  late int Price; 
  late String Location;
  late double longitude;
  late double latitude;
  late String physical_address;
  late int place_id;
  NewPLace({required this.place_id, required this.Name, required this.Description, required this.rating, required this.Tags, required this.Is_Approved, required this.Price, required this.votesNum, required this.Location});
  NewPLace.fromJson(Map<String, dynamic> json) {
    Location = json["Location"];
    Name = json["Name"];
    Description = json["Description"];
    votesNum = json['votesNum'];
    // Owner = json["Owner"];
    rating = json["rating"];
    Tags = json["Tags"];
    Is_Approved = json["Is_Approved"];
    Price = json["Price"];
    place_id = json["id"];

  }

  Map<String, dynamic> toJson() {
    return {
      "Name": Name,
      "Description": Description,
      "rating": rating,
      "votesNum": votesNum,
      "Tags": Tags,
      "Is_Approved": Is_Approved,
      "Price": Price,
      "Location": Location,
      "id": place_id,
    };
  }
}

Future<List<String>> getImages(int place_id)async{
  List<String> images= [];
Uri uri = Uri.parse("https://paveltrty.pythonanywhere.com/api/album/${place_id}/");
    Response response = await get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body) as List;
      list.forEach((json) {
       final image = json['Image'];
        images.add('https://paveltrty.pythonanywhere.com${image!.substring(7)}');
      });
    } else {
      images.add('https://img.freepik.com/free-vector/stylish-white-background-with-diagonal-lines_1017-33199.jpg');
      //images.add('/post_images/qrcode.png');//////////////////////////////error
      print("error");
    }
    return images;
} 


