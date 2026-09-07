/// Model representing an Authorized Recycler verified by CPCB / State Pollution Control Board.
class AuthorizedRecycler {
  final String id;
  final String name;
  final double distanceKm;
  final List<String> acceptedCategories;
  final double rating;
  final int reviewsCount;
  final bool pickupAvailable;
  final String locationAddress;
  final String phone;
  final String licenseNumber;
  final double offeredRatePerKg;
  final String workingHours;

  const AuthorizedRecycler({
    required this.id,
    required this.name,
    required this.distanceKm,
    required this.acceptedCategories,
    required this.rating,
    required this.reviewsCount,
    required this.pickupAvailable,
    required this.locationAddress,
    required this.phone,
    required this.licenseNumber,
    required this.offeredRatePerKg,
    this.workingHours = '9:00 AM - 7:00 PM',
  });
}
