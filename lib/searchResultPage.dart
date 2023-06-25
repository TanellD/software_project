import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({required this.searchQuery});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Center(
        child: Text(
          'Displaying search results for: ${widget.searchQuery}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
