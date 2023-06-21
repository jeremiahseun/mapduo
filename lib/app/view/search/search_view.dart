// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mapduo/app/view/search/search_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> searchResults = [
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4',
    'Location 5',
    'Location 6',
    'Location 7',
    'Location 8',
    'Location 9',
    'Location 10',
  ];

  @override
  void dispose() {
    Provider.of<SearchViewModel>(context, listen: false)
        .searchController
        .dispose();
    super.dispose();
  }

  void onSearchTextChanged(String value) {
    setState(() {
      // Perform the search operation here based on the entered text
      // and update the searchResults list accordingly.
      // For simplicity, we'll filter the list based on the value entered.
      searchResults = value.isEmpty
          ? [] // Empty the list when search text is cleared
          : searchResults
              .where(
                (location) =>
                    location.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Search'),
      ),
      body: Consumer<SearchViewModel>(
        builder: (context, search, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  onSubmitted: (value) => search.searchForLocation(value),
                  controller: search.searchController,
                  onChanged: search.onSearchTextChanged,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final location = searchResults[index];
                    return ListTile(
                      title: Text(location),
                      onTap: () => search.onLocationSelected(location),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
