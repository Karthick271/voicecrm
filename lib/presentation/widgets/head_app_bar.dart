import 'package:flutter/material.dart';
import 'package:voicecrm/core/theme/app_colors.dart';

import '../../constants/app_typography.dart';
 

class HeadAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool showMenuButton;
  final bool centerTitle;
  final VoidCallback? onMorePressed;

  const HeadAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.showMenuButton =  false,
    this.centerTitle =  false,
    this.onMorePressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:  AppColors.surfaceColor,
      centerTitle: centerTitle,
        surfaceTintColor:   AppColors.surfaceColor, // Ensures no blending effect
 elevation: 4, // Adds a slight shadow
  shadowColor: Colors.black.withOpacity(0.1), // Customize shadow
       leading: showMenuButton
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: AppColors.textSecondary),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: Text(
        title,
        style: AppTypography.headline1.copyWith(color: AppColors.textSecondary),
      ),
      actions: [
        
        // IconButton(
        //   icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
        //   onPressed: onMorePressed ??
        //       () {
        //         Navigator.pushNamed(context, AppRoutes.settings);
        //       },
        // ),
        ...actions,
      ],
    );
  }
}
