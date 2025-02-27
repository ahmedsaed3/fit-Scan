// lib/api/model.dart

class Exercises {
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String id;
  final String name;
  final String target;
  final List<String> secondaryMuscles;
  final List<String> instructions;
  final String type; // Add the type field for age group categorization

  Exercises({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
    required this.type, // Initialize type
  });



  // Factory method to create Training instances from JSON
  factory Exercises.fromJson(Map<String, dynamic> json) {
    return Exercises(
      bodyPart: json['bodyPart'],
      equipment: json['equipment'],
      gifUrl: json['gifUrl'],
      id: json['id'],
      name: json['name'],
      target: json['target'],
      secondaryMuscles: List<String>.from(json['secondaryMuscles'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      type: json['type'] ?? '', // Provide a default value for type
    );
  }
}
