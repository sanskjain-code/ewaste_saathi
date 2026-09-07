import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Large, easy-to-tap action card for the main home dashboard.
class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget iconWidget;
  final VoidCallback onTap;
  final bool isProminent;
  final Color? badgeColor;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconWidget,
    required this.onTap,
    this.isProminent = false,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isProminent ? const Color(0xFFF0FDF4) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isProminent ? AppColors.primary : AppColors.border,
          width: isProminent ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isProminent
                ? AppColors.primary.withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.primaryLight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              children: [
                // Leading Icon Container
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: badgeColor ??
                        (isProminent
                            ? AppColors.primary
                            : AppColors.primaryLight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: iconWidget,
                ),
                const SizedBox(width: 16),
                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isProminent
                              ? AppColors.primaryDark
                              : AppColors.textDark,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Trailing Arrow
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isProminent
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: isProminent
                        ? AppColors.primary
                        : AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
