import 'package:flutter/material.dart';

/// AppColors defines the clean, accessible color palette tailored for informal
/// e-waste collectors (kabadiwalas) with high contrast and friendly green accents.
class AppColors {
  // Primary Greens
  static const Color primary = Color(0xFF15803D); // Forest Green
  static const Color primaryDark = Color(0xFF14532D);
  static const Color primaryLight = Color(0xFFDCFCE7); // Light mint background
  static const Color primaryHover = Color(0xFF166534);

  // Accent & Secondary
  static const Color accent = Color(0xFF22C55E); // Fresh Leaf Green
  static const Color earningsGold = Color(0xFFD97706); // Amber Gold for ₹ earnings
  static const Color earningsLight = Color(0xFFFEF3C7); // Warm amber background

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF8FAF9); // Warm crisp off-white
  static const Color cardSurface = Colors.white;
  static const Color cardSurfaceAlt = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textDark = Color(0xFF0F172A); // High-contrast Charcoal
  static const Color textMedium = Color(0xFF475569); // Slate secondary text
  static const Color textLight = Color(0xFF94A3B8); // Muted placeholder/label

  // Status Colors
  static const Color statusCompleted = Color(0xFF16A34A); // Vibrant Green
  static const Color statusCompletedBg = Color(0xFFDCFCE7);
  static const Color statusPending = Color(0xFFEA580C); // Vibrant Orange
  static const Color statusPendingBg = Color(0xFFFFEDD5);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSelected = Color(0xFF15803D);

  // Recycler Verified Badge
  static const Color verifiedBlue = Color(0xFF2563EB);
  static const Color verifiedBlueBg = Color(0xFFDBEAFE);
}
