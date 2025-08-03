import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_typography.dart';
 
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? assetImagePath;
  final double spacing;
  final double imageHeight;
  final Widget? action;
  final IconData fallbackIcon;
  final Color? fallbackIconColor;

  const EmptyStateWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.assetImagePath,
    this.spacing = 20.0,
    this.imageHeight = 200.0,
    this.action,
    this.fallbackIcon = Icons.help,
    this.fallbackIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color iconColor = fallbackIconColor ?? AppColors.primary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display image if provided, else fallback icon
            if (assetImagePath != null)
              Image.asset(
                assetImagePath!,
                height: imageHeight,
                fit: BoxFit.contain,
              )
            else
              Icon(
                fallbackIcon,
                size: imageHeight * 0.6,
                color: iconColor,
              ),

            SizedBox(height: spacing),

            Text(
              title,
              style: AppTypography.body,
              textAlign: TextAlign.center,
            ),

            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: AppTypography.body .copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],

            if (action != null) ...[
              const SizedBox(height: 20),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
