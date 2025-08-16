import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote.dart';

class QuoteStorage {
  static const String _key = "favorite_quotes";

  static Future<List<Quote>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((q) => Quote.fromJson(jsonDecode(q))).toList();
  }

  static Future<void> saveFavorites(List<Quote> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final data = favorites.map((q) => jsonEncode(q.toJson())).toList();
    await prefs.setStringList(_key, data);
  }
}
