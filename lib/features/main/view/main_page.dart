import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/extension/app_extension.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_styles.dart';
import '../../products/view/add_product_page.dart';
import '../../products/view/store_page.dart';
import '../../profile/view/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<IconData> _navIcons = const [
    Icons.home_outlined,
    Icons.add_circle_outline,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [const StorePage(), AddProductPage(), const ProfilePage()];

    final appBarTitles = [
      'nav.home'.locale,
      'nav.add'.locale,
      'nav.profile'.locale,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[_currentIndex]),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cart),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _navIcons.length,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor: Theme.of(context).colorScheme.surface,
        splashColor: AppColors.secondary,
        splashRadius: AppSizes.lg,
        leftCornerRadius: AppSizes.radiusLg,
        rightCornerRadius: AppSizes.radiusLg,
        onTap: (index) => setState(() => _currentIndex = index),
        tabBuilder: (index, isActive) {
          final color = isActive
              ? AppColors.primary
              : Theme.of(context).colorScheme.onSurfaceVariant;
          final labels = [
            'nav.home'.locale,
            'nav.add'.locale,
            'nav.profile'.locale,
          ];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_navIcons[index], color: color),
              SizedBox(height: AppSizes.xxs),
              Text(
                labels[index],
                style: AppStyles.xSmall.copyWith(
                  color: color,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
