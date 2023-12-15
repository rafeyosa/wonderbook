import 'chapter.dart';

class Book {
  String id;
  String name;
  String? description;
  String? pictureUrl;
  double? rating;
  String? author;
  String? release;
  List<String>? genre;
  List<Chapter>? chapters;

  Book({
    required this.id,
    required this.name,
    this.description,
    this.pictureUrl,
    this.rating,
    this.author,
    this.release,
    this.genre,
    this.chapters,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureUrl: json["pictureUrl"],
    rating: json["rating"]?.toDouble(),
    author: json["author"],
    release: json["release"],
    genre: json["genre"] == null ? [] : List<String>.from(json["genre"]!.map((x) => x)),
    chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureUrl": pictureUrl,
    "rating": rating,
    "author": author,
    "release": release,
    "genre": genre == null ? [] : List<dynamic>.from(genre!.map((x) => x)),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
  };
}

