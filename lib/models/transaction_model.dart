/// Model representing a collection transaction / digital payment record.
class CollectionTransaction {
  final String id;
  final String lotId;
  final String categorySummary;
  final double weightKg;
  final double amount;
  final String status; // 'Completed' or 'Pending'
  final String date;
  final String recyclerName;
  final String paymentMode;

  const CollectionTransaction({
    required this.id,
    required this.lotId,
    required this.categorySummary,
    required this.weightKg,
    required this.amount,
    required this.status,
    required this.date,
    required this.recyclerName,
    this.paymentMode = 'Direct UPI / Bank Transfer',
  });

  bool get isCompleted => status.toLowerCase() == 'completed';
}
