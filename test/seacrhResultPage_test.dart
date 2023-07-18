import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:software_project/searchResultPage.dart';

@GenerateMocks([http.Client])
void main() {
  test('Test getPosts function', () async {
    final response = http.Response(
      '{"number_of_images": 2, "images_adresses": ["image1.jpg", "image2.jpg"], "number_of_comments": 1, "place_name": "Test Place", "rating": 4.5, "description": "Test description", "address": "Test address", "latitude": 0.0, "longitude": 0.0, "comments": []}',
      200,
    );

    // Create a mock HTTP client that returns the predefined response
    final mockClient = MockClient((request) async => response);

    // Replace the original HTTP client with the mock client
    final httpClient = mockClient;

    // Call the getPosts function
    final result = await getPosts();

    // Verify the result
    //expect(result.length, );
    expect(result[0].Name, "Kul Sharif Mosque");
    expect(result[0].Description, "Cool place");
    expect(result[0].Price, 0);
  });
}