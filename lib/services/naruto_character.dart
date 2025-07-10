class NarutoCharacter {
  final String name;
  final String image;
  final String debut;
  final String clan;
  final String? status;
  final List<String>? jutsu;

  NarutoCharacter({
    required this.name,
    required this.image,
    required this.debut,
    required this.clan,
    this.status,
    this.jutsu,
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

    return NarutoCharacter(
      name: json['name'] ?? 'Sin nombre',
      image: imageUrl,
      debut: json['debut']?['anime'] ?? 'Desconocido',
      clan: clanName,
      status: json['personal']?['status'] as String?,
      jutsu: json['jutsu'] is List ? List<String>.from(json['jutsu']) : null,
    );
  }
  
}
