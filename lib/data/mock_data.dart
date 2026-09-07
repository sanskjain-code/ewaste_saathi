import 'package:flutter/material.dart';
import '../models/lot_model.dart';
import '../models/recycler_model.dart';
import '../models/transaction_model.dart';

/// AppState manages the mock state reactively throughout the application session.
class AppState extends ChangeNotifier {
  // Collector Profile
  String collectorName = 'Ramesh Kumar';
  String collectorPhone = '9876543221';
  String collectorLocation = 'Indore, Madhya Pradesh';
  String collectorId = 'COL-10245';

  // Statistics
  double todayWeightKg = 24.5;
  double todayEstimatedValue = 2450.0;
  int monthLotsCount = 18;
  double monthTotalWeightKg = 186.0;
  double monthTotalEarnings = 18500.0;

  // Language setting
  String currentLanguage = 'Hinglish'; // 'Hindi', 'English', 'Hinglish'

  // Lots List
  List<EWasteLot> lots = [
    const EWasteLot(
      id: 'EW-2026-00125',
      title: 'Mobile Phones',
      categories: ['Mobile / Smartphone'],
      weightKg: 24.5,
      estimatedValue: 2450.0,
      status: 'Completed',
      date: '06 Sep 2026',
      photoPresetKey: 'mobile_lot',
      matchedRecyclerName: 'GreenCycle Recycling',
    ),
    const EWasteLot(
      id: 'EW-2026-00120',
      title: 'Laptop Parts',
      categories: ['Laptop / Computer'],
      weightKg: 18.0,
      estimatedValue: 1800.0,
      status: 'Pending',
      date: '05 Sep 2026',
      photoPresetKey: 'laptop_lot',
      matchedRecyclerName: 'EcoTech Recyclers',
    ),
    const EWasteLot(
      id: 'EW-2026-00115',
      title: 'Electronics Scrap',
      categories: ['Electrical Items', 'Battery'],
      weightKg: 32.0,
      estimatedValue: 3200.0,
      status: 'Completed',
      date: '03 Sep 2026',
      photoPresetKey: 'circuit_lot',
      matchedRecyclerName: 'Clean Earth Recycling',
    ),
  ];

  // Transactions List
  List<CollectionTransaction> transactions = [
    const CollectionTransaction(
      id: 'TXN-98421',
      lotId: 'EW-2026-00125',
      categorySummary: 'Mobile + Electronics',
      weightKg: 24.5,
      amount: 2450.0,
      status: 'Completed',
      date: '06 Sep 2026',
      recyclerName: 'GreenCycle Recycling',
      paymentMode: 'Instant UPI - Ramesh@upi',
    ),
    const CollectionTransaction(
      id: 'TXN-98389',
      lotId: 'EW-2026-00120',
      categorySummary: 'Laptop + Computer Parts',
      weightKg: 18.0,
      amount: 1800.0,
      status: 'Pending',
      date: '05 Sep 2026',
      recyclerName: 'EcoTech Recyclers',
      paymentMode: 'Pending Verification at Center',
    ),
    const CollectionTransaction(
      id: 'TXN-98210',
      lotId: 'EW-2026-00115',
      categorySummary: 'Mixed Electrical & Battery',
      weightKg: 32.0,
      amount: 3200.0,
      status: 'Completed',
      date: '03 Sep 2026',
      recyclerName: 'Clean Earth Recycling',
      paymentMode: 'Direct Bank NEFT',
    ),
    const CollectionTransaction(
      id: 'TXN-97994',
      lotId: 'EW-2026-00108',
      categorySummary: 'Monitor & Cathode Displays',
      weightKg: 45.0,
      amount: 4500.0,
      status: 'Completed',
      date: '28 Aug 2026',
      recyclerName: 'GreenCycle Recycling',
      paymentMode: 'Instant Cash Receipt',
    ),
  ];

  // Recyclers List
  final List<AuthorizedRecycler> recyclers = const [
    AuthorizedRecycler(
      id: 'REC-01',
      name: 'GreenCycle Recycling',
      distanceKm: 8.5,
      acceptedCategories: ['Mobile / Smartphone', 'Laptop / Computer', 'Electrical Items'],
      rating: 4.6,
      reviewsCount: 142,
      pickupAvailable: true,
      locationAddress: 'Plot 42, Sanwer Road Industrial Area, Sector A, Indore',
      phone: '+91 94250 11223',
      licenseNumber: 'MP-PCB-AUTH-2024-0089',
      offeredRatePerKg: 105.0,
      workingHours: '8:30 AM - 7:30 PM (Mon-Sat)',
    ),
    AuthorizedRecycler(
      id: 'REC-02',
      name: 'EcoTech Recyclers',
      distanceKm: 12.0,
      acceptedCategories: ['Monitor / TV', 'Refrigerator / AC', 'Laptop / Computer'],
      rating: 4.8,
      reviewsCount: 209,
      pickupAvailable: true,
      locationAddress: 'Facility 7, Pithampur Industrial Belt, Sector 3, Indore',
      phone: '+91 98260 44556',
      licenseNumber: 'CPCB-EWASTE-IND-2023-441',
      offeredRatePerKg: 110.0,
      workingHours: '9:00 AM - 6:30 PM (All Days)',
    ),
    AuthorizedRecycler(
      id: 'REC-03',
      name: 'Clean Earth Recycling',
      distanceKm: 5.2,
      acceptedCategories: ['Battery', 'Electrical Items', 'Other E-Waste'],
      rating: 4.5,
      reviewsCount: 98,
      pickupAvailable: false,
      locationAddress: 'Shop 12, Kabadi Market Yard, Palda Naka, Indore',
      phone: '+91 91112 33445',
      licenseNumber: 'MP-PCB-AUTH-2025-1102',
      offeredRatePerKg: 98.0,
      workingHours: '10:00 AM - 8:00 PM (Mon-Sat)',
    ),
  ];

  // Helper method to add newly created lot and corresponding transaction
  void addNewLot({
    required String title,
    required List<String> categories,
    required double weightKg,
    required double estimatedValue,
    String? photoPresetKey,
    String? matchedRecyclerName,
  }) {
    final nextIndex = lots.length + 126;
    final lotId = 'EW-2026-00$nextIndex';
    final txnId = 'TXN-98${nextIndex + 300}';

    final newLot = EWasteLot(
      id: lotId,
      title: title.isNotEmpty ? title : categories.join(', '),
      categories: categories,
      weightKg: weightKg,
      estimatedValue: estimatedValue,
      status: 'Pending',
      date: '06 Sep 2026',
      photoPresetKey: photoPresetKey,
      matchedRecyclerName: matchedRecyclerName ?? 'GreenCycle Recycling',
    );

    final newTxn = CollectionTransaction(
      id: txnId,
      lotId: lotId,
      categorySummary: categories.join(' + '),
      weightKg: weightKg,
      amount: estimatedValue,
      status: 'Pending',
      date: '06 Sep 2026',
      recyclerName: matchedRecyclerName ?? 'GreenCycle Recycling',
      paymentMode: 'Pending Recycler Inspection',
    );

    lots.insert(0, newLot);
    transactions.insert(0, newTxn);

    // Update stats
    todayWeightKg += weightKg;
    todayEstimatedValue += estimatedValue;
    monthLotsCount += 1;
    monthTotalWeightKg += weightKg;
    monthTotalEarnings += estimatedValue;

    notifyListeners();
  }

  void toggleLanguage() {
    if (currentLanguage == 'Hinglish') {
      currentLanguage = 'Hindi';
    } else if (currentLanguage == 'Hindi') {
      currentLanguage = 'English';
    } else {
      currentLanguage = 'Hinglish';
    }
    notifyListeners();
  }
}
