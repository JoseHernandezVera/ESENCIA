class AkatsukiMember {
  final String name;
  final String description;
  final String image;
  final String? status;
  final List<String>? abilities;

  AkatsukiMember({
    required this.name,
    required this.description,
    required this.image,
    this.status,
    this.abilities,
  });

  factory AkatsukiMember.fromJson(Map<String, dynamic> json) {

    String imageUrl = '';
    if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'].first;
    } else if (json['image'] != null) {
      imageUrl = json['image'];
    }

    return AkatsukiMember(
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: imageUrl,
      status: json['status'] as String?,
      abilities: json['abilities'] is List ? List<String>.from(json['abilities']) : null,
    );
  }
}