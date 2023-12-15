class Chapter {
  String id;
  String name;
  String? uploadDate;
  String? content;

  Chapter({
    required this.id,
    required this.name,
    this.uploadDate,
    this.content,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    name: json["name"],
    uploadDate: json["uploadDate"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "uploadDate": uploadDate,
    "content": content,
  };
}