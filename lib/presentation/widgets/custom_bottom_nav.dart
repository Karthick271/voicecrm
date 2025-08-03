import 'package:flutter/material.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textSecondary ?? Colors.grey,
      backgroundColor: AppColors.surfaceColor ?? Colors.white,
      selectedLabelStyle: AppTypography.bodyLarge.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      unselectedLabelStyle: AppTypography.bodyLarge.copyWith(
        fontSize: 12,
        color: AppColors.textSecondary ?? Colors.grey,
      ),
      items: [
        _buildNavItem(
          icon: Icons.contacts,
          index: 0,
          label: 'Contacts',
        ),
        _buildNavItem(
          icon: Icons.dialpad,
          index: 1,
          label: 'Dialer',
        ),
        _buildNavItem(
          icon: Icons.phone_in_talk,
          index: 2,
          label: 'Call',
        ),
        _buildNavItem(
          icon: Icons.mic,
          index: 3,
          label: 'Recordings',
        ),
        _buildNavItem(
          icon: Icons.person,
          index: 4,
          label: 'Profile',
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required int index,
    required String label,
  }) {
    final bool isSelected = index == currentIndex;

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.12),
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          size: 22,
          color: isSelected ? AppColors.primaryColor : AppColors.textSecondary ?? Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
