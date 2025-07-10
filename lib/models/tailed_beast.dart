class TailedBeast {
  final String name;
  final String description;
  final String image;
  final int? tails;
  final String? jinchuriki;

  TailedBeast({
    required this.name,
    required this.description,
    required this.image,
    this.tails,
    this.jinchuriki,
  });

  factory TailedBeast.fromJson(Map<String, dynamic> json) {

    String imageUrl = '';
    if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'].first;
    } else if (json['image'] != null) {
      imageUrl = json['image'];
    }

    return TailedBeast(
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: imageUrl,
      tails: json['tails'] as int?,
      jinchuriki: json['jinchuriki'] as String?,
    );
  }
}