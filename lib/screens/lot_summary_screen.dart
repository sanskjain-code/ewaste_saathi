import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import 'lot_success_screen.dart';

/// Screen 4: Confirmation screen showing details before final submission.
class LotSummaryScreen extends StatelessWidget {
  final AppState appState;
  final String photoLabel;
  final String photoEmoji;
  final List<String> selectedCategories;
  final double weightKg;
  final double estimatedValue;

  const LotSummaryScreen({
    super.key,
    required this.appState,
    required this.photoLabel,
    required this.photoEmoji,
    required this.selectedCategories,
    required this.weightKg,
    required this.estimatedValue,
  });

  void _confirmLot(BuildContext context) {
    final nextId = 'EW-2026-00${appState.lots.length + 126}';

    // Add to app state repository
    appState.addNewLot(
      title: selectedCategories.join(' + '),
      categories: selectedCategories,
      weightKg: weightKg,
      estimatedValue: estimatedValue,
      photoPresetKey: photoLabel,
    );

    // Navigate to Success screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LotSuccessScreen(
          appState: appState,
          lotId: nextId,
          weightKg: weightKg,
          categories: selectedCategories,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Collection Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Collection Details Check Karein 📋',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Sabhi details sahi hain toh niche Confirm Lot button dabayein.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMedium,
                ),
              ),

              const SizedBox(height: 20),

              // Detailed Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.border, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Photo Row Preview
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            photoEmoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'PHOTO ATTACHED',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                photoLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(height: 1, color: AppColors.border),
                    const SizedBox(height: 18),

                    // Categories Row
                    _buildSummaryItem(
                      emoji: '📱',
                      label: 'Category (Prakar)',
                      valueWidget: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selectedCategories.map((c) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              c,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 18),
                    const Divider(height: 1, color: AppColors.border),
                    const SizedBox(height: 18),

                    // Weight Row
                    _buildSummaryItem(
                      emoji: '⚖️',
                      label: 'Total Weight',
                      valueWidget: Text(
                        '${weightKg.toStringAsFixed(1)} kg',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    const Divider(height: 1, color: AppColors.border),
                    const SizedBox(height: 18),

                    // Estimated Value Row
                    _buildSummaryItem(
                      emoji: '💰',
                      label: 'Estimated Value',
                      valueWidget: Text(
                        '₹${estimatedValue.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Action Buttons
              CustomButton(
                text: 'Confirm Lot ✅',
                onPressed: () => _confirmLot(context),
              ),

              const SizedBox(height: 12),

              CustomButton(
                text: 'Edit (Badlav Karein) ✏️',
                isOutlined: true,
                onPressed: () => Navigator.of(context).pop(),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem({
    required String emoji,
    required String label,
    required Widget valueWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMedium,
                ),
              ),
              const SizedBox(height: 4),
              valueWidget,
            ],
          ),
        ),
      ],
    );
  }
}
