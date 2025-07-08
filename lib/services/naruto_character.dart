class NarutoCharacter {
  final String name;
  final String image;
  final String debut;
  final String clan;

  NarutoCharacter({
    required this.name,
    required this.image,
    required this.debut,
    required this.clan,
  });

  factory NarutoCharacter.fromJson(Map<String, dynamic> json) {
    //se toma la primera iamgen si existe
    final imageList = json['images'];
    String imageUrl = '';

    if (imageList != null && imageList is List && imageList.isNotEmpty && imageList[0] is String) {
      imageUrl = imageList[0];
    }

    final debutAnime = json['debut']?['anime'] ?? 'Desconocido';

    String clanName = 'Desconocido';
    final rawClan = json['personal']?['clan'];
    if (rawClan != null) {
      if (rawClan is String) {
        clanName = rawClan;
      } else if (rawClan is List) {
        clanName = rawClan.join(', ');
      }
    }

    return NarutoCharacter(
      name: json['name'] ?? 'Sin nombre',
      image: imageUrl,
      debut: debutAnime,
      clan: clanName,
    );
  }


}
