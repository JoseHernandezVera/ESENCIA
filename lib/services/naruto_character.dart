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
    //se toma la primera iamgen si existe
    final imageList = json['images'];
    String imageUrl = '';

    if (imageList != null && imageList is List && imageList.isNotEmpty && imageList[0] is String) {
      imageUrl = imageList[0];
    }

    final debutAnime = json['debut']?['anime'] ?? 'Desconocido';

    return NarutoCharacter(
      name: json['name'] ?? 'Sin nombre',
      image: imageUrl,
      debut: debutAnime,
    );
  }


}
