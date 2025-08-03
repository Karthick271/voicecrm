import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'dart:math' as math;

class CustomDrawerHeader extends StatelessWidget {
  final String? userName;

  const CustomDrawerHeader({super.key, this.userName});

  // Helper: get initials or default letter
  String getInitials() {
    if (userName == null || userName!.trim().isEmpty) return "G";
    final parts = userName!.trim().split(" ");
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = (userName?.isNotEmpty ?? false) ? userName! : 'Guest';
    final initials = getInitials();

    return DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.appBarColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stylized avatar with initials or fallback
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: Text(
              initials,
              style: AppTypography.headline6.copyWith(
                color: Colors.blueAccent,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'simple and smart',
            style: AppTypography.bodyText1.copyWith(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                displayName,
                style: AppTypography.bodyText1.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
