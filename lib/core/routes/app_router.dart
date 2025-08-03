import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/item_list_screen.dart';
import '../../presentation/screens/main_shell.dart';
import '../../presentation/screens/splash_screen.dart';
import '../models/item_model.dart';

// Import your screens (adjust paths as needed)
 
// ...add other screens

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [

    GoRoute(
  path: '/splash',
  builder: (context, state) => const SplashScreen(),
),
GoRoute(
  path: '/home',
  builder: (context, state) => const MainShell(),
),

GoRoute(
  path: '/items',
  builder: (context, state) => ItemListScreen(
    items: [
      ItemModel(id: "1", title: "Item One", subtitle: "First Item"),
      ItemModel(id: "2", title: "Item Two", subtitle: "Second Item"),
      // ...add more or fetch from API/provider
    ],
  ),
),

// GoRoute(
//   path: '/onboarding',
//   builder: (context, state) => const UsernameInputPage(),
// ),
// ...other routes

    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => const LandingPage(),
    // ),
    // GoRoute(
    //   path: '/posts',
    //   builder: (context, state) => const PostsScreen(),
    // ),
    // GoRoute(
    //   path: '/settings',
    //   builder: (context, state) => const SettingsPage(),
    // ),
    // GoRoute(
    //   path: '/theme-settings',
    //   builder: (context, state) => const ThemeSelectionPage(),
    // ),
    // Example dynamic param (for details page)
    // GoRoute(
    //   path: '/details/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id'];
    //     return DetailScreen(id: id);
    //   },
    // ),
//     GoRoute(
//   path: '/details/:id',
//   builder: (context, state) {
//     final id = state.pathParameters['id'];
//     return DetailScreen(id: id);
//   },
// ),

    // ...add more routes/screens
  ],
  // errorBuilder: (context, state) => const PageNotFound(),
);
