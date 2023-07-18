import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Import the file containing the _sendPlacetRequest method
import 'package:software_project/addNewLocationPage.dart' as page;

Future<int> _sendPlacetRequest(Map<String, dynamic> newPlace) async {
    await Future.delayed(Duration(seconds: 3), () {});
    print("Connecting to Internet");
    String addPlace = jsonEncode(newPlace);
    print(addPlace);
    
      http.Response responsePost = await http.post(
        Uri.parse("https://paveltrty.pythonanywhere.com/api/place/"),
        headers: {'Content-Type': 'application/json'},
        body: addPlace,
      );

      if (responsePost.statusCode == 200 || responsePost.statusCode == 201) {
        return responsePost.statusCode;
      } else {
       return responsePost.statusCode;
      }
    
  }

void main() {
  test('Post request should return code 201 if successful', () async {

    // Create a new place object for testing
    Map<String, dynamic> newPlace = {
      "Description": "Test description",
      "rating": 5.0,
      "Name": "Test place",
      "tags": "Test tag",
      "Owner": null,
      "Is_Approved": true,
      "Price": 0
    };

    // Replace the http client with the mock client
    //http.Client client = mockClient;

    // Call the method under test
    expect(await _sendPlacetRequest(newPlace), 201 );
    
  });
}
