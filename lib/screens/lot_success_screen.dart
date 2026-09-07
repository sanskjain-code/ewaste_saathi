import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import 'recycler_list_screen.dart';

/// Screen 4.2: Success screen after lot creation with quick link to recycler options.
class LotSuccessScreen extends StatelessWidget {
  final AppState appState;
  final String lotId;
  final double weightKg;
  final List<String> categories;

  const LotSuccessScreen({
    super.key,
    required this.appState,
    required this.lotId,
    required this.weightKg,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated/Large Success Badge
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.check_rounded,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'E-Waste Lot Successfully Created! 🎉',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Aapka e-waste lot system mein add ho chuka hai. Ab paas ke authorized recyclers se connect karein.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMedium,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 24),

              // Lot ID Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Column(
                  children: [
                    const Text(
                      'LOT ID NUMBER',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textLight,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      lotId,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryDark,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '⚖️ ${weightKg.toStringAsFixed(1)} kg  •  ${categories.join(", ")}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Primary Action: Recycler Options Dekhein
              CustomButton(
                text: 'Recycler Options Dekhein ♻️',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RecyclerListScreen(
                        appState: appState,
                        fromLotId: lotId,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Return to Dashboard
              CustomButton(
                text: 'Home / Dashboard Par Jayein 🏠',
                isOutlined: true,
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
