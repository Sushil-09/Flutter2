import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../services/quote_storage.dart';
import '../data/quotes.dart';
import '../widgets/quote_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Quote todayQuote;
  List<Quote> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _pickQuoteOfTheDay();
  }

  void _pickQuoteOfTheDay() {
    final random = Random();
    setState(() {
      todayQuote = quotes[random.nextInt(quotes.length)];
    });
  }

  Future<void> _loadFavorites() async {
    favorites = await QuoteStorage.loadFavorites();
    setState(() {});
  }

  Future<void> _saveFavorites() async {
    await QuoteStorage.saveFavorites(favorites);
  }

  void _toggleFavorite() {
    if (!favorites.any((q) => q.text == todayQuote.text)) {
      favorites.add(todayQuote);
      _saveFavorites();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Added to Favorites")));
    }
  }

  void _shareQuote() {
    Share.share('"${todayQuote.text}" - ${todayQuote.author}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Inspiration"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(favorites: favorites),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: QuoteCard(
          quote: todayQuote,
          onFavorite: _toggleFavorite,
          onShare: _shareQuote,
        ),
      ),
    );
  }
}
