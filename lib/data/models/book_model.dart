class AuthorModel {
  final String name;
  final int? birthYear;
  final int? deathYear;

  AuthorModel({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: (json['name'] as String).split(', ').reversed.join(' '),
      birthYear: json['birth_year'] as int?,
      deathYear: json['death_year'] as int?,
    );
  }
}

class BookModel {
  final int id;
  final String title;
  final List<AuthorModel> authors;
  final List<String> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final String mediaType;
  final Map<String, String> formats;
  final int downloadCount;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((author) => AuthorModel.fromJson(author as Map<String, dynamic>))
          .toList(),
      translators: (json['translators'] as List<dynamic>)
          .map((translator) => translator as String)
          .toList(),
      subjects: (json['subjects'] as List<dynamic>)
          .map((subject) => subject as String)
          .toList(),
      bookshelves: (json['bookshelves'] as List<dynamic>).map((bookshelf) {
        String shelf = bookshelf as String;
        return shelf.startsWith('Browsing: ')
            ? shelf.substring('Browsing: '.length)
            : shelf;
      }).toList(),
      languages: (json['languages'] as List<dynamic>)
          .map((language) => language as String)
          .toList(),
      copyright: json['copyright'] as bool,
      mediaType: json['media_type'] as String,
      formats: Map<String, String>.from(
          json['formats'] as Map), // Ensure correct typing
      downloadCount: json['download_count'] as int,
    );
  }

  String? getCoverImageUrl() {
    return formats['image/jpeg'];
  }

  String getPrimaryAuthorName() {
    return authors.isNotEmpty ? authors[0].name : 'Unknown Author';
  }

  String getPrimaryLanguage() {
    return languages.isNotEmpty ? languages[0] : 'unknown';
  }

  String? getHtmlUrl() {
    return formats['text/html'];
  }

  String? getEpubUrl() {
    return formats['application/epub+zip'];
  }
}
