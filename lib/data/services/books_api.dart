import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled1/data/models/book_model.dart';

Future<List<BookModel>> fetchBooks() async {
  try {
    await dotenv.load(fileName: ".env");
    final url = dotenv.env['BASE_URL'];
    if (url == null) {
      throw Exception('BASE_URL not found');
    }
    final dio = Dio();
    final Response response = await dio.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
    final Map<String, dynamic> responseData = response.data;
    print(responseData);
    final List<dynamic> results = responseData['results'] as List<dynamic>;
    // final List shortList = results.sublist(0, 26);
    final List<BookModel> books =
        results.map((book) => BookModel.fromJson(book as Map)).toList();
    return books;
  } catch (e) {
    print('Error fetching books: $e');
    rethrow;
  }
}
