import 'package:flutter/material.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/features/explore/presentation/pages/explore_page.dart';
import 'package:real_estate_app/features/home/presentation/pages/home_page.dart';
import 'package:real_estate_app/features/root/presentation/widgets/bottom_bar_item.dart';
import 'package:real_estate_app/features/property/presentation/pages/property_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _activeTab = 2;
  final List _barItems = [
    {
      "icon": Icons.search_outlined,
      "active_icon": Icons.search,
      "page": const ExplorePage(),
    },
    {
      "icon": Icons.forum_outlined,
      "active_icon": Icons.forum_rounded,
      "page": HomePage(),
    },
    {
      "icon": Icons.home_filled,
      "active_icon": Icons.home_filled,
      "page": HomePage(),
    },
    {
      "icon": Icons.favorite_outlined,
      "active_icon": Icons.favorite_outlined,
      "page": const PropertyPage(),
    },
    {
      "icon": Icons.person,
      "active_icon": Icons.person,
      "page": HomePage(),
    },
  ];

  double _bottom = -100;

  void _togglePosition() {
    if (mounted) {
      setState(() {
        _bottom =
            _bottom == -100 ? MediaQuery.of(context).padding.bottom + 10 : -100;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1300), () {
        _togglePosition();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        IndexedStack(
          index: _activeTab,
          sizing: StackFit.expand,
          children: List.generate(
            _barItems.length,
            (index) => _barItems[index]["page"],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          bottom: _bottom,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: _buildBottomBar(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 60,
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.bottomBarBackground,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          _barItems.length,
          (index) => BottomBarItem(
            icon: _activeTab == index
                ? _barItems[index]["active_icon"]
                : _barItems[index]["icon"],
            isActive: _activeTab == index,
            activeColor: AppColors.bottomBarActive,
            activeBgColor: AppColors.bottomBarActiveBackground,
            inactiveBgColor: AppColors.bottomBarInactiveBackground,
            inactiveColor: AppColors.bottomBarInactive,
            onTap: () {
              setState(() {
                _activeTab = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
