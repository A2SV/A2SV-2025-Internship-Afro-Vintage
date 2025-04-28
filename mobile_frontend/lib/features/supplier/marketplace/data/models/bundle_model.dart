// Model for a bundle item
class BundleModel {
  final String id;
  final String title;
  final String grade;
  final num price;
  final String type;
  final String status;
  final String sampleImage;
  final String description;
  final int quantity;
  final int declaredRating;
  final String sizeRange;
  final String sortingLevel;
  final dynamic estimatedBreakdown;
  final DateTime? createdAt;

  BundleModel({
    required this.id,
    required this.title,
    required this.grade,
    required this.price,
    required this.type,
    required this.status,
    required this.sampleImage,
    required this.description,
    required this.quantity,
    required this.declaredRating,
    required this.sizeRange,
    required this.sortingLevel,
    this.estimatedBreakdown,
    this.createdAt,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) {
    // Debug print to see the raw JSON
    print('[DEBUG] BundleModel.fromJson raw data: $json');

    // Helper function to safely get string values
    String getString(String key, {String defaultValue = ''}) {
      final value = json[key];
      print('[DEBUG] Getting string for key: $key, value: $value');
      if (value == null || value.toString().trim().isEmpty) {
        print('[DEBUG] Using default value for $key: $defaultValue');
        return defaultValue;
      }
      final result = value.toString().trim();
      print('[DEBUG] Returning value for $key: $result');
      return result;
    }

    // Helper function to safely get numeric values
    num getNumber(String key, {num defaultValue = 0}) {
      final value = json[key];
      print('[DEBUG] Getting number for key: $key, value: $value');
      if (value == null) {
        print('[DEBUG] Using default value for $key: $defaultValue');
        return defaultValue;
      }
      if (value is num) {
        print('[DEBUG] Returning numeric value for $key: $value');
        return value;
      }
      final result = num.tryParse(value.toString()) ?? defaultValue;
      print('[DEBUG] Returning parsed value for $key: $result');
      return result;
    }

    // Helper function to safely get integer values
    int getInt(String key, {int defaultValue = 0}) {
      final value = json[key];
      print('[DEBUG] Getting integer for key: $key, value: $value');
      if (value == null) {
        print('[DEBUG] Using default value for $key: $defaultValue');
        return defaultValue;
      }
      if (value is int) {
        print('[DEBUG] Returning integer value for $key: $value');
        return value;
      }
      final result = int.tryParse(value.toString()) ?? defaultValue;
      print('[DEBUG] Returning parsed value for $key: $result');
      return result;
    }

    // Extract the actual bundle data from the response
    final data = json['data'] ?? json['bundle'] ?? json;
    print('[DEBUG] Extracted bundle data: $data');

    final model = BundleModel(
      id: getString('id'),
      title: getString('title'),
      grade: getString('grade', defaultValue: 'A'),
      price: getNumber('price'),
      type: getString('type', defaultValue: 'sorted'),
      status: getString('status', defaultValue: 'available'),
      sampleImage: getString('sample_image'),
      description: getString('description'),
      quantity: getInt('quantity'),
      declaredRating: getInt('declared_rating', defaultValue: 5),
      sizeRange: getString('size_range'),
      sortingLevel: getString('sorting_level', defaultValue: 'sorted'),
      estimatedBreakdown: data['estimated_breakdown'],
      createdAt: data['created_at'] != null ? DateTime.parse(data['created_at']) : null,
    );

    // Debug print to see the parsed model
    print('[DEBUG] BundleModel parsed data:');
    print('[DEBUG] ID: ${model.id}');
    print('[DEBUG] Title: ${model.title}');
    print('[DEBUG] Description: ${model.description}');
    print('[DEBUG] Quantity: ${model.quantity}');
    print('[DEBUG] Grade: ${model.grade}');
    print('[DEBUG] Rating: ${model.declaredRating}');
    print('[DEBUG] Type: ${model.type}');
    print('[DEBUG] Status: ${model.status}');
    print('[DEBUG] Sample Image: ${model.sampleImage}');
    print('[DEBUG] Price: ${model.price}');
    print('[DEBUG] Size Range: ${model.sizeRange}');
    print('[DEBUG] Sorting Level: ${model.sortingLevel}');
    print('[DEBUG] Created At: ${model.createdAt}');
    
    return model;
  }

  @override
  String toString() {
    return 'BundleModel(id: $id, title: $title, grade: $grade, price: $price, type: $type, status: $status, sampleImage: $sampleImage, description: $description, quantity: $quantity, declaredRating: $declaredRating, sizeRange: $sizeRange, sortingLevel: $sortingLevel, estimatedBreakdown: $estimatedBreakdown, createdAt: $createdAt)';
  }
}
