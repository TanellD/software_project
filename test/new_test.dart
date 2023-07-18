import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:software_project/loginPage.dart';
import 'package:software_project/sign_up_new.dart';

void main() {
  testWidgets('SignupPage - Form submission', (WidgetTester tester) async {
    // Build the SignupPage widget
    await tester.pumpWidget(MaterialApp(home: SignupPage()));

    // Fill in the text fields with valid values
    await tester.enterText(find.byType(TextFormField).at(0), 'john@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.enterText(find.byType(TextFormField).at(2), 'password');

    // Tap the submit button
    await tester.tap(find.widgetWithText(InkWell, 'Sign up'));
    await tester.pump();
    await tester.tap(find.widgetWithText(InkWell, 'Sign up'));
    await tester.pump();
    await tester.pump();
    await tester.pump();


    // Verify that the form is submitted
   expect(find.text('Form submitted'), findsOneWidget); 
  });
}