import 'dart:convert';
import 'package:iclick_flutter_practical_test/Model/book.dart';
import 'package:http/http.dart' as http;


class BookRepository {
  final String apiUrl = 'https://api.itbook.store/1.0/';

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('${apiUrl}new'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List books = data['books'];
        return books.map((book) => Book.fromJson(book)).toList();
      } else {
       // developer.log('Failed to load books with status code: ${response.statusCode}', name: 'BookRepository');
        throw Exception('Failed to load books with status code: ${response.statusCode}');
      }
    } catch (e) {
      //developer.log('Exception caught: $e', name: 'BookRepository');
      throw Exception('Failed to load books: $e');
    }
  }
}
