class Point {
  int id;
  String titleRu;

  Point({
    required this.id,
    required this.titleRu,
  });

  factory Point.empty() {
    return Point(id: 0, titleRu: '');
  }

  Point.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        titleRu = json['title_ru'];
}
