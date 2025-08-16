import 'package:flutter/material.dart';
import '../models/quote.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Quote> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Quotes")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet!"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favorites[index].text),
                  subtitle: Text("- ${favorites[index].author}"),
                );
              },
            ),
    );
  }
}
