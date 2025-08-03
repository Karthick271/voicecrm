import 'package:flutter/material.dart';
import '../../core/services/page_service.dart';
import '../widgets/custom_bottom_nav.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index); // Navigate to selected page
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = PageService.getPages(); // Get pages from service

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe gestures
        children: _pages.isNotEmpty
            ? _pages
            : [const Center(child: Text('No pages available'))],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped, // Pass the onTap method
      ),
    );
  }
}
