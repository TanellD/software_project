import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:software_project/mainPageView.dart' as MainPage;
import 'package:software_project/searchResultPage.dart';



void main() {
  
  testWidgets('MainPageView widget test', (WidgetTester tester) async {
    // Create a mock album for testing
    final album = Album(
      images_adresses: ['mock_image'],
      country: 'country',
      distance: 10,
      number_of_images: 1,
      number_of_comments: 1,
      place_name: 'place_name',
      rating: 2,
      description: 'description',
      address: 'address',
      latitude: 10,
      longtitude: 10,
      comments: [
        Comment(
          date_of_post: 'date_of_post',
          given_rating: 2,
          user_id: 1,
          text: 'text',
          images_addresses: ['none'],
        ),
      ],
    );

  await mockNetworkImages(() async {
    
      await tester.pumpWidget(MaterialApp(home: MainPage.MainPageView(album: album)), Duration(seconds: 1));
    
      
      await tester.pumpAndSettle(const Duration(seconds: 5));
    // Verify the presence of the place name
    expect(await find.text(album.place_name), findsOneWidget);

    // Verify the presence of the description
    expect(await find.text(album.description), findsOneWidget);
    

    // Verify the presence of the rating stars
    //expect(find.byIcon(Icons.star), findsNWidgets(album.rating.toInt()));

    // Verify the presence of the comment text
    //expect(find.text(album.comments[0].text), findsOneWidget);
    });
    

    



  });
}
