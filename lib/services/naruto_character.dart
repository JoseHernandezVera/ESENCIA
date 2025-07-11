class NarutoCharacter {
  final String name;
  final String image;
  final String debut;
  final String clan;
  final String gender;
  final String height;
  final String affiliation;
  final String nature;

  NarutoCharacter({
    required this.name,
    required this.image,
    required this.debut,
    required this.clan,
    required this.gender,
    required this.height,
    required this.affiliation,
    required this.nature,
  });

  factory NarutoCharacter.fromJson(Map<String, dynamic> json) {

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

    final affiliation = (json['affiliation'] is List)
        ? json['affiliation'].join(', ')
        : (json['affiliation'] ?? 'Desconocida');

    final nature = (json['natureType'] is List)
        ? json['natureType'].join(', ')
        : (json['natureType'] ?? 'Desconocido');

    return NarutoCharacter(
      name: json['name'] ?? 'Sin nombre',
      image: imageUrl,
      debut: debutAnime,
      clan: clanName,
      gender: json['personal']?['sex'] ?? 'Desconocido',
      height: json['personal']?['height']?.toString() ?? 'Desconocida',
      affiliation: affiliation,
      nature: nature,
    );
  }


}
