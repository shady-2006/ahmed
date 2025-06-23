class PersonImage {
  final String filePath;

  PersonImage({required this.filePath});

  factory PersonImage.fromJson(Map<String, dynamic> json) {
    return PersonImage(filePath: json['file_path']);
  }
}
