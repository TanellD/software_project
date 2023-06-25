import 'package:flutter/material.dart';
import 'package:software_project/culturalAndArchitecture.dart';
import 'package:software_project/culturalEventsAndFestival.dart';
import 'package:software_project/galleryAndMuseum.dart';
import 'package:software_project/historicalLandmarks.dart';
import 'package:software_project/loginPage.dart';
import 'package:software_project/parksAndNaturalAttractions.dart';
import 'package:software_project/searchResultPage.dart';
import 'package:software_project/sportAndEntertainmentVenues.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(0.0, 0.0), // Updated initial Offset to (0.0, 0.0)
      end: Offset.zero,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() {
      if (isMenuOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isMenuOpen = !isMenuOpen;
    });
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter your search query'),
            onSubmitted: (String value) {
              // Perform search or any other actions with the entered value
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Search'),
              onPressed: () {
                // Perform search or any other actions with the entered value
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFEBF4FA),
        toolbarHeight: 170,
        title: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: toggleMenu,
                  child: Icon(Icons.menu, color: Color(0xFF3797D0)),
                ),
                SizedBox(
                  width: 25,
                ),
                if (isMenuOpen)
                  SlideTransition(
                    position: _animation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            // Handle star icon tapped
                          },
                          child: Icon(
                            Icons.star,
                            color: Color(0xFF3797D0),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            // Handle lightbulb icon tapped
                          },
                          child: Icon(
                            Icons.lightbulb,
                            color: Color(0xFF3797D0),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            // Handle person icon tapped
                          },
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF3797D0),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            // Handle settings icon tapped
                          },
                          child: Icon(
                            Icons.settings,
                            color: Color(0xFF3797D0),
                          ),
                        ),
                      ],
                    ),
                  ),
                Spacer(),
                InkWell(
                  onTap: () {
                    // Code to navigate to a new page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.login, color: Color(0xFF3797D0)),
                      Text(
                        "Sign in",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Code to navigate to a new page or handle the search bar tap
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.41),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,
                          ),
                          hintText: 'Discover stunning destination',
                          hintStyle: TextStyle(
                            color: Color(0xFF000000).withOpacity(0.24),
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          // Handle text field tap if needed
                        },
                        onChanged: (String value) {
                          // Handle text field changes if needed
                        },
                        onSubmitted: (String value) {
                          // Navigate to a new page with search results
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchResultsPage(searchQuery: value),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(
              "KazanTravel",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3797D0)),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFEBF4FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 4),
                  child: InkWell(
                    onTap: () {
                      // Code to navigate to a new page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoricalLandmark()),
                      );
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Historical Landmark",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.advantour.com/img/russia/tours/moscow-kazan-tour/kazan2.jpg"),
                              fit: BoxFit.cover)),
                      width: 151,
                      height: 165,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 16, right: 15),
                      child: InkWell(
                        onTap: () {
                          // Code to navigate to a new page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CulturalAndArchitectural()),
                          );
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  "Cultural and Architectural",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://www.advantour.com/img/russia/tours/moscow-kazan-tour/kazan2.jpg"),
                                  fit: BoxFit.cover)),
                          width: 151,
                          height: 165,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 4),
                  child: InkWell(
                    onTap: () {
                      // Code to navigate to a new page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MuseumsAndGalleries()),
                      );
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Museums and Galleries",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.advantour.com/img/russia/tours/moscow-kazan-tour/kazan2.jpg"),
                              fit: BoxFit.cover)),
                      width: 151,
                      height: 165,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 16, right: 15),
                      child: InkWell(
                        onTap: () {
                          // Code to navigate to a new page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SportAndEntertainmentVenues()),
                          );
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  "Sport and Entertainment Venues",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://www.advantour.com/img/russia/tours/moscow-kazan-tour/kazan2.jpg"),
                                  fit: BoxFit.cover)),
                          width: 151,
                          height: 165,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 4, bottom: 15),
                  child: InkWell(
                    onTap: () {
                      // Code to navigate to a new page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ParksAndNaturalAttractions()),
                      );
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Parks and Natural Attractions",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.advantour.com/img/russia/tours/moscow-kazan-tour/kazan2.jpg"),
                              fit: BoxFit.cover)),
                      width: 151,
                      height: 165,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 16, right: 15, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          // Code to navigate to a new page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CulturalFestivalAndEvents()),
                          );
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Cultural Festival and Events",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://www.advantour.com/img/russia/tours/moscow-kazan-tour/kazan2.jpg"),
                                  fit: BoxFit.cover)),
                          width: 151,
                          height: 165,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

