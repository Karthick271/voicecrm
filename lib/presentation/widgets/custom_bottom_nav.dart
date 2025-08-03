import 'package:flutter/material.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

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
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: AppColors.surfaceColor,
      selectedLabelStyle: AppTypography.bodyLarge.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      unselectedLabelStyle: AppTypography.bodyLarge.copyWith(
        fontSize: 12,
        color: AppColors.textSecondary,
      ),
      items: [
        _buildNavItem(
          icon: Icons.article,
          index: 0,
          label: 'Posts',
        ),
        _buildNavItem(
          icon: Icons.manage_search_sharp,
          index: 1,
          label: 'SEO blog',
        ),
        _buildNavItem(
          icon: Icons.link,
          index: 2,
          label: 'Integration',
        ),
        _buildNavItem(
          icon: Icons.attach_money,
          index: 3,
          label: 'Expense',
        ),
        _buildNavItem(
          icon: Icons.history,
          index: 4,
          label: 'Test',
        ),
        _buildNavItem(
          icon: Icons.more_horiz,
          index: 5,
          label: 'Login & More',
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
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          size: 20,
          color: isSelected ? AppColors.primaryColor : AppColors.textSecondary,
        ),
      ),
      label: label,
    );
  }
}
