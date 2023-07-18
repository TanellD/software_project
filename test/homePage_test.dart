import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:software_project/loginPage.dart';
import 'package:software_project/main.dart';
import 'package:software_project/mainPageView.dart';
import 'package:software_project/profilePage.dart';
import 'package:software_project/searchResultPage.dart';

void main() {
  // testWidgets('HomePage Widget Test', (WidgetTester tester) async {
  //   // Build the widget
  //   await tester.pumpWidget(MaterialApp(home: HomePage(),));

  //   // Verify that the HomePage widget is rendered
  //   expect(find.byType(HomePage), findsOneWidget);

  //   // Verify that the SignInIcon is set to Icon(Icons.login)
  //   expect(SignInIcon.icon, Icons.login);

  //   // Verify that the Text "KazanTravel" is rendered
  //   //expect(find.text("KazanTravel"), findsOneWidget);

  //   // Verify that the ImageSquares are rendered
  //   expect(find.byType(ImageSquare), findsNWidgets(5));

  //   // Verify that the BottomAppBar is rendered
  //   expect(find.byType(BottomAppBar), findsOneWidget);

  //   // Verify that the initial value of signedIn is false
  //   expect(signedIn, false);
  // });

  testWidgets('SearchResultsPage Widget Test', (WidgetTester tester) async {

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: SearchResultsPage(headerMessage: 'Mock Header'),
      ),
    );

    // Verify that the SearchResultsPage widget is rendered
    expect(find.byType(SearchResultsPage), findsOneWidget);

    // Verify that the header message is displayed
    expect(find.text('Mock Header'), findsOneWidget);

    // Verify that the PageView is rendered with the correct number of images
    expect(find.byType(await PageView), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(3));

    // Verify that the place name, rating, and number of reviews are displayed
    expect(find.text('Mock Place'), findsOneWidget);
    expect(find.text('4.5 reviews'), findsOneWidget);
    expect(find.text('100 reviews'), findsOneWidget);

    // Verify that the address is displayed
    expect(find.text('Mock Address'), findsOneWidget);

    // Verify that the back button is rendered
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
  });
  
  testWidgets('MainPageView Widget Test', (WidgetTester tester) async {
    // Create a mock album
Album mockAlbum = Album.fromJson({
  'number_of_images': 3,
  'images_adresses': [
    'https://cdni.rbth.com/rbthmedia/images/2017.11/original/5a02d6ba15e9f930e73cdf3e.jpg',
    'https://cdni.rbth.com/rbthmedia/images/2017.11/original/5a02d6ba15e9f930e73cdf3e.jpg',
    'https://cdni.rbth.com/rbthmedia/images/2017.11/original/5a02d6ba15e9f930e73cdf3e.jpg',
  ],
  'number_of_comments': 100,
  'place_name': 'Mock Place',
  'rating': 4.5,
  'description': '',
  'address': 'Mock Address',
  'latitude': 40.7128,
  'longitude': -74.0060,
  'comments': [],
});

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: MainPageView(album: mockAlbum),
      ),
    );

    // Verify that the MainPageView widget is rendered
    expect(find.byType(MainPageView), findsOneWidget);

    // Verify that the place name is displayed
    expect(find.text('Mock Place'), findsOneWidget);

    // Verify that the rating and number of reviews are displayed
    expect(find.text('4.5 reviews'), findsOneWidget);
    expect(find.text('100 reviews'), findsOneWidget);

    // Verify that the address is displayed
    expect(find.text('Mock Address'), findsOneWidget);

    // Verify that the back button is rendered
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
  });
  
  testWidgets('ProfilePage Widget Test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Verify that the ProfilePage widget is rendered
    expect(find.byType(ProfilePage), findsOneWidget);
  });

  testWidgets('LoginPage Widget Test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    // Verify that the LoginPage widget is rendered
    expect(find.byType(LoginPage), findsOneWidget);
  });
}