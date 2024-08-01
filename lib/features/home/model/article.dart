import 'dart:math';

class Article {
  final String title;
  final String description;
  final String fullText;
  final String author;
  final DateTime date;
  final List<String> comments;

  Article({
    required this.title,
    required this.description,
    required this.fullText,
    required this.author,
    required this.date,
    required this.comments,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String fullText = json['text'] ?? '';
    List<String> sentences = fullText.split('. ');

    // Generate random author and date
    String author = _generateRandomAuthor();
    DateTime date = _generateRandomDate();

    return Article(
      title: fullText.split(' ').take(3).join(' '),
      description: sentences.take(2).join('. '),
      fullText: fullText,
      author: author,
      date: date,
      comments: List<String>.from(json['comments'] ?? []),
    );
  }

  static String _generateRandomAuthor() {
    const authors = [
      'John Doe',
      'Jane Smith',
      'Alice Johnson',
      'Robert Brown',
      'Emily Davis',
      'Michael Wilson'
    ];
    final random = Random();
    return authors[random.nextInt(authors.length)];
  }

  static DateTime _generateRandomDate() {
    final random = Random();
    final now = DateTime.now();
    final randomDays = random.nextInt(30);
    final randomDate = now.subtract(Duration(days: randomDays));
    // return '${randomDate.year}-${randomDate.month.toString().padLeft(2, '0')}-${randomDate.day.toString().padLeft(2, '0')}';
    return randomDate;
  }
}