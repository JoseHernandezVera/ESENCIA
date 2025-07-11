class NarutoCharacter {
  final String name;
  final String image;
  final String debut;
  final String clan;
  final String? status;
  final List<String>? jutsu;
  final String gender;
  final String height;
  final String affiliation;
  final String nature;

  NarutoCharacter({
    required this.name,
    required this.image,
    required this.debut,
    required this.clan,
    this.status,
    this.jutsu,
    required this.gender,
    required this.height,
    required this.affiliation,
    required this.nature,
  });

  factory NarutoCharacter.fromJson(Map<String, dynamic> json) {
    String imageUrl = '';
    if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'].first;
    } else if (json['image'] != null) {
      imageUrl = json['image'];
    }

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
      debut: json['debut']?['anime'] ?? 'Desconocido',
      clan: clanName,
      status: json['personal']?['status'] as String?,
      jutsu: json['jutsu'] is List ? List<String>.from(json['jutsu']) : null,
      gender: json['personal']?['sex'] ?? 'Desconocido',
      height: json['personal']?['height']?.toString() ?? 'Desconocida',
      affiliation: affiliation,
      nature: nature,
    );
  }
}