import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/action_card.dart';
import '../widgets/stat_card.dart';
import 'create_lot_screen.dart';
import 'recycler_list_screen.dart';

/// Screen 2: Main Home / Dashboard Screen.
class DashboardScreen extends StatelessWidget {
  final AppState appState;
  final Function(int) onTabChange;

  const DashboardScreen({
    super.key,
    required this.appState,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header with Greeting, Notification & Profile Icon
              Row(
                children: [
                  // Collector Avatar
                  GestureDetector(
                    onTap: () => onTabChange(3), // Go to profile
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: const Text('👨🏽‍💼', style: TextStyle(fontSize: 26)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Greeting & ID
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Namaste, ${appState.collectorName.split(' ').first} ji 👋',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'ID: ${appState.collectorId}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textMedium,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '📍 Indore',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Notification Icon
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Aapke pass 1 naya recycler pickup request hai!',
                              ),
                              backgroundColor: AppColors.primaryDark,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          size: 28,
                          color: AppColors.textDark,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // SECTION 1: MAIN ACTION CARDS
              const Text(
                'Mukhya Suvidhayein (Quick Actions)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Action Card 1 (Prominent)
              ActionCard(
                title: 'Naya E-Waste Lot Banayein',
                subtitle: 'Aaj ka collected e-waste add karein',
                isProminent: true,
                iconWidget: const Text('📦', style: TextStyle(fontSize: 28)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateLotScreen(appState: appState),
                    ),
                  );
                },
              ),

              // Action Card 2
              ActionCard(
                title: 'Mere Transactions',
                subtitle: 'Purane collection aur payments dekhein',
                iconWidget: const Text('📋', style: TextStyle(fontSize: 26)),
                onTap: () => onTabChange(2), // Switch to Transactions tab
              ),

              // Action Card 3
              ActionCard(
                title: 'Authorized Recycler Dhundhein',
                subtitle: 'Apne paas ke recycler se connect karein',
                iconWidget: const Text('♻️', style: TextStyle(fontSize: 26)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          RecyclerListScreen(appState: appState),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // SECTION 2: COLLECTION SUMMARY SECTION
              const Text(
                'Collection Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Aaj ka Collection
              StatCard(
                title: 'Aaj ka Collection 📅',
                primaryValue: '${appState.todayWeightKg.toStringAsFixed(1)} kg',
                primaryLabel: 'Total Weight',
                secondaryValue: '₹${appState.todayEstimatedValue.toStringAsFixed(0)}',
                secondaryLabel: 'Estimated Value',
                highlightColor: AppColors.primary,
              ),

              // This Month Summary
              StatCard(
                title: 'This Month (Mahina) 📊',
                primaryValue: '${appState.monthLotsCount}',
                primaryLabel: 'Lots Collected',
                secondaryValue: '${appState.monthTotalWeightKg.toStringAsFixed(0)} kg',
                secondaryLabel: 'Total Weight',
                tertiaryValue: '₹${appState.monthTotalEarnings.toStringAsFixed(0)}',
                tertiaryLabel: 'Earnings',
                highlightColor: AppColors.primaryDark,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
