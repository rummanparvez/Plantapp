class Plant {
  final String id;
  final String commonName;
  final String scientificName;
  final String family;
  final String description;
  final Map<String, String> careInstructions;
  final String imageUrl;
  final double probability;
  final List<String> similarPlants;

  Plant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.family,
    required this.description,
    required this.careInstructions,
    required this.imageUrl,
    required this.probability,
    required this.similarPlants,
  });

  // Factory method to create a Plant from JSON
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] ?? '',
      commonName: json['common_name'] ?? '',
      scientificName: json['scientific_name'] ?? '',
      family: json['family'] ?? '',
      description: json['description'] ?? '',
      careInstructions: Map<String, String>.from(json['care_instructions'] ?? {}),
      imageUrl: json['image_url'] ?? '',
      probability: (json['probability'] ?? 0).toDouble(),
      similarPlants: List<String>.from(json['similar_plants'] ?? []),
    );
  }

  // Convert Plant to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'common_name': commonName,
      'scientific_name': scientificName,
      'family': family,
      'description': description,
      'care_instructions': careInstructions,
      'image_url': imageUrl,
      'probability': probability,
      'similar_plants': similarPlants,
    };
  }
}