class Team {
  final String name;
  final String description;
  final String image;
  final List<String>? members;
  final String? affiliation;

  Team({
    required this.name,
    required this.description,
    required this.image,
    this.members,
    this.affiliation,
  });

  factory Team.fromJson(Map<String, dynamic> json) {

    String imageUrl = '';
    if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'].first;
    } else if (json['image'] != null) {
      imageUrl = json['image'];
    }

    return Team(
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: imageUrl,
      members: json['members'] is List ? List<String>.from(json['members']) : null,
      affiliation: json['affiliation'] as String?,
    );
  }
}