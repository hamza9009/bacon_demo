import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/article.dart';

class ArticleRepository {
  final String apiUrl = "https://baconipsum.com/api/?type=meat-and-filler&paras=10";

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Article> articles = jsonResponse.map((article) => Article.fromJson({
        'text': article,
        'author': null,
        'date': null,
        'comments': ['Comment 1', 'Comment 2']
      })).toList();

      // Sort articles by date (most recent first)
      articles.sort((a, b) => b.date.compareTo(a.date));

      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}