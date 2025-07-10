class Village {
  final String name;
  final String description;
  final String image;
  final String? country;
  final String? leader;

  Village({
    required this.name,
    required this.description,
    required this.image,
    this.country,
    this.leader,
  });

  factory Village.fromJson(Map<String, dynamic> json) {

    String imageUrl = '';
    if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'].first;
    } else if (json['image'] != null) {
      imageUrl = json['image'];
    }

    return Village(
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: imageUrl,
      country: json['country'] as String?,
      leader: json['leader'] as String?,
    );
  }
}