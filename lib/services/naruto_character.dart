class NarutoCharacter {
  final String name;
  final String image;
  final String debut;

  NarutoCharacter({
    required this.name,
    required this.image,
    required this.debut,
  });

  factory NarutoCharacter.fromJson(Map<String, dynamic> json) {
    return NarutoCharacter(
      name: json['name'],
      image: json['images']['main'],
      debut: json['debut']['anime'] ?? 'Desconocido',
    );
  }
}
