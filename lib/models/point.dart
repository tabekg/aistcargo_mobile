class Point {
  int id;
  String title;

  Point({
    required this.id,
    required this.title,
  });

  factory Point.empty() {
    return Point(id: 0, title: '');
  }
}
