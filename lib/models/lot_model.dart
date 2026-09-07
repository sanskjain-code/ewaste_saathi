/// Model representing an E-Waste Lot created by the collector.
class EWasteLot {
  final String id;
  final String title;
  final List<String> categories;
  final double weightKg;
  final double estimatedValue;
  final String status; // 'Completed' or 'Pending'
  final String date;
  final String? photoPresetKey; // Key for visual asset/photo representation
  final String? matchedRecyclerName;

  const EWasteLot({
    required this.id,
    required this.title,
    required this.categories,
    required this.weightKg,
    required this.estimatedValue,
    required this.status,
    required this.date,
    this.photoPresetKey,
    this.matchedRecyclerName,
  });

  bool get isCompleted => status.toLowerCase() == 'completed';

  EWasteLot copyWith({
    String? id,
    String? title,
    List<String>? categories,
    double? weightKg,
    double? estimatedValue,
    String? status,
    String? date,
    String? photoPresetKey,
    String? matchedRecyclerName,
  }) {
    return EWasteLot(
      id: id ?? this.id,
      title: title ?? this.title,
      categories: categories ?? this.categories,
      weightKg: weightKg ?? this.weightKg,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      status: status ?? this.status,
      date: date ?? this.date,
      photoPresetKey: photoPresetKey ?? this.photoPresetKey,
      matchedRecyclerName: matchedRecyclerName ?? this.matchedRecyclerName,
    );
  }
}
