class EnvIncidents {
  String title;
  String description;
  String imagePath;

  EnvIncidents(
      {required this.title,
      required this.description,
      required this.imagePath});

  factory EnvIncidents.fromJson(Map<String, dynamic> json) {
    return EnvIncidents(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        imagePath: json['imagePath']);
  }
}
