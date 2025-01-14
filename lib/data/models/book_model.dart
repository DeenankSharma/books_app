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

  factory BookModel.fromJson(dynamic json) {
    List<dynamic> authorsList = json['authors'] ?? [];
    List<dynamic> translatorsList = json['translators'] ?? [];
    List<dynamic> subjectsList = json['subjects'] ?? [];
    List<dynamic> bookshelfList = json['bookshelves'] ?? [];
    List<dynamic> languagesList = json['languages'] ?? [];

    Map<String, dynamic> formatsMap = json['formats'] ?? {};
    Map<String, String> sanitizedFormats = {};
    formatsMap.forEach((key, value) {
      if (value != null) {
        sanitizedFormats[key.toString()] = value.toString();
      }
    });

    return BookModel(
      id: json['id']?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      authors:
          authorsList.map((author) => AuthorModel.fromJson(author)).toList(),
      translators: translatorsList
          .map((translator) => translator?.toString() ?? '')
          .where((str) => str.isNotEmpty)
          .toList(),
      subjects: subjectsList
          .map((subject) => subject?.toString() ?? '')
          .where((str) => str.isNotEmpty)
          .toList(),
      bookshelves: bookshelfList
          .map((bookshelf) {
            String shelf = bookshelf?.toString() ?? '';
            return shelf.startsWith('Browsing: ')
                ? shelf.substring('Browsing: '.length)
                : shelf;
          })
          .where((str) => str.isNotEmpty)
          .toList(),
      languages: languagesList
          .map((language) => language?.toString() ?? '')
          .where((str) => str.isNotEmpty)
          .toList(),
      copyright: json['copyright'] == true,
      mediaType: json['media_type']?.toString() ?? '',
      formats: sanitizedFormats,
      downloadCount: json['download_count']?.toInt() ?? 0,
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
