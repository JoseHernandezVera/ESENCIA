class KekkeiGenkai {
  final String name;
  final String description;
  final String image;
  final List<String>? users;
  final String? classification;

  KekkeiGenkai({
    required this.name,
    required this.description,
    required this.image,
    this.users,
    this.classification,
  });

  factory KekkeiGenkai.fromJson(Map<String, dynamic> json) {

    String imageUrl = '';
    if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'].first;
    } else if (json['image'] != null) {
      imageUrl = json['image'];
    }

    return KekkeiGenkai(
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: imageUrl,
      users: json['users'] is List ? List<String>.from(json['users']) : null,
      classification: json['classification'] as String?,
    );
  }
}