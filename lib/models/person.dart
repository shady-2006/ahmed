class Person {
  final int id;
  final String name;
  final String? profilePath;
  final String? biography;
  final String? birthday;
  final String? placeOfBirth;
  final String? knownForDepartment;
  final List<String>? alsoKnownAs;
  final int? gender;
  final double? popularity;
  final String? deathday;

  Person({
    required this.id,
    required this.name,
    this.profilePath,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    this.knownForDepartment,
    this.alsoKnownAs,
    this.gender,
    this.popularity,
    this.deathday,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      biography: json['biography'],
      birthday: json['birthday'],
      placeOfBirth: json['place_of_birth'],
      knownForDepartment: json['known_for_department'],
      alsoKnownAs: (json['also_known_as'] as List?)?.map((e) => e.toString()).toList(),
      gender: json['gender'],
      popularity: (json['popularity'] is int)
          ? (json['popularity'] as int).toDouble()
          : json['popularity'],
      deathday: json['deathday'],
    );
  }

  @override
  String toString() => 'Person(id: $id, name: $name, profilePath: $profilePath)';
}
