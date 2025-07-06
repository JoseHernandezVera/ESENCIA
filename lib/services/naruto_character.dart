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
    final imageUrl = json['images']?['main'] ?? '';
    final debutAnime = json['debut']?['anime'] ?? 'Desconocido';

    return NarutoCharacter(
      name: json['name'] ?? 'Sin nombre',
      image: imageUrl,
      debut: debutAnime,
    );
  }
}
