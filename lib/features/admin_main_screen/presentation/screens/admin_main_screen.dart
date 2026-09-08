import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/doctors_list/presentation/screens/doctors_list_screen.dart';
import 'package:doctor_hunt_app/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:doctor_hunt_app/features/home/presentation/screens/home_screen.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminMainScreen();
  }
}

class _AdminMainScreen extends State<AdminMainScreen> {
  int _currentIndex = 0;
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );
  int maxCount = 2;

  final List<Widget> _screens = [DoctorsListScreen(), FavoriteScreen()];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          TopLeftShadowWidget(),

          BottomRightShadowWidget(),
          IndexedStack(index: _currentIndex, children: _screens),
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              IconsAssets.medicalIcon,
              color: AppColors.inactiveIconColor,
            ),
            activeItem: SvgPicture.asset(
              IconsAssets.medicalIcon,
              color: AppColors.primaryColor,
            ),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              color: AppColors.inactiveIconColor,
            ),
            activeItem: Icon(Icons.settings, color: AppColors.primaryColor),
          ),
        ],
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
        kIconSize: 20,
        kBottomRadius: 20,
      ),
    );
  }
}
