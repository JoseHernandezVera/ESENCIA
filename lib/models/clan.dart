class Clan {
  final String name;
  final String description;
  final String image;
  final String? affiliation;
  final List<String>? members;

  Clan({
    required this.name,
    required this.description,
    required this.image,
    this.affiliation,
    this.members,
  });

  factory Clan.fromJson(Map<String, dynamic> json) {

    String imageUrl = '';
    if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'].first;
    } else if (json['image'] != null) {
      imageUrl = json['image'];
    }

    return Clan(
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: imageUrl,
      affiliation: json['affiliation'] as String?,
      members: json['members'] is List ? List<String>.from(json['members']) : null,
    );
  }
}