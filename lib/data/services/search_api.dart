import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled1/data/models/book_model.dart';

Future<List<BookModel>> searchBooks(String query) async {
  try {
    await dotenv.load(fileName: ".env");
    final url = dotenv.env['BASE_URL'];
    if (url == null) {
      throw Exception('BASE_URL not found');
    }
    final String new_query =
        query.toLowerCase().trim().split(RegExp(r'\s+')).join('%20');
    final dio = Dio();
    final String urlToRequest = '$url?search=$new_query';
    final Response response = await dio.get(urlToRequest);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
    final Map<String, dynamic> responseData = response.data;
    final List<dynamic> results = responseData['results'] as List<dynamic>;
    final List<BookModel> books =
        results.map((book) => BookModel.fromJson(book)).toList();
    return books;
  } catch (e) {
    print('Error fetching books: $e');
    rethrow;
  }
}
