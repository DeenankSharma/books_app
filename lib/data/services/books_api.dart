import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled1/data/models/book_model.dart';

Future<List<BookModel>> fetchBooks(String page) async {
  try {
    await dotenv.load(fileName: ".env");
    final url = dotenv.env['BASE_URL'];
    if (url == null) {
      throw Exception('BASE_URL not found');
    }

    final dio = Dio();
    final urlToRequest = '$url?page=$page';
    final Response response = await dio.get(urlToRequest);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }

    final Map responseData = response.data;
    final List results = responseData['results'] as List;
    List<BookModel> books = results
        .map((book) => BookModel.fromJson(book as Map))
        .toList()
        .sublist(0, 5);

    return books;
  } catch (e) {
    print('Error fetching books: $e');
    rethrow;
  }
}
