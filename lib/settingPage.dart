import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_project/aboutAppVersion.dart';
import 'package:software_project/privacyAndData.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();

  ThemeData get currentTheme => _currentTheme;

  set currentTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }

  void toggleTheme() {
    _currentTheme = _currentTheme.brightness == Brightness.light
        ? ThemeData.dark()
        : ThemeData.light();
    notifyListeners();
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;
  String selectedLanguage = 'English';
  bool areNotificationsEnabled = true;
  String name = 'John Doe';
  String email = 'johndoe@example.com';
  String password = '********';

  List<String> availableLanguages = [
    'English',
    'Russian (soon)',
    'Tatar (soon)'
  ];

  void _setThemeMode(ThemeMode themeMode) {
    final currentTheme = Theme.of(context);
    final newTheme = ThemeData(
      brightness:
          themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      primaryColor: currentTheme.primaryColor,
      // Define other theme properties as needed
    );

    // Apply the new theme
    Provider.of<ThemeProvider>(context, listen: false).currentTheme = newTheme;

    // Update the isDarkModeEnabled value
    setState(() {
      isDarkModeEnabled = themeMode == ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF4FA),
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF3797D0),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Language Selection'),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: availableLanguages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
// Implement logic to update app's language based on the selected value
                });
              },
            ),
          ),
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value: areNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  areNotificationsEnabled = value;
// Implement logic to manage notification preferences
                });
              },
            ),
          ),
//           ListTile(
//             title: Text('Account Settings'),
//             onTap: () {
// // Implement logic to navigate to account settings screen
//             },
//           ),
          ListTile(
            title: Text('Privacy and Data Usage'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyAndDataUsagePage(),
                ),
              );

// Implement logic to navigate to privacy settings screen
            },
          ),
          ListTile(
            title: Text('About and App Version'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutAndAppVersionPage(),
                ),
              );

// Implement logic to navigate to about screen
            },
          ),
        ],
      ),
    );
  }
}
