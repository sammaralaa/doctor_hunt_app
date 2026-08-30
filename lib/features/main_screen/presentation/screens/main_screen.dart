import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:doctor_hunt_app/features/home/presentation/screens/home_screen.dart';
import 'package:doctor_hunt_app/features/main_screen/presentation/widgets/custom_icon_bottom_nav.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  int _currentIndex = 0;
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );
  int maxCount = 4;

  final List<Widget> _screens = [
    HomeScreen(),
    FavoriteScreen(),
    Center(child: Text('News Screen', style: TextStyle(fontSize: 20))),
    Center(child: Text('Chat Screen', style: TextStyle(fontSize: 20))),
  ];
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
              IconsAssets.home,
              color: AppColors.inactiveIconColor,
            ),
            activeItem: SvgPicture.asset(
              IconsAssets.home,
              color: AppColors.primaryColor,
            ),
          ),
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              IconsAssets.favorite,
              color: AppColors.inactiveIconColor,
            ),
            activeItem: SvgPicture.asset(
              IconsAssets.favorite,
              color: AppColors.primaryColor,
            ),
          ),
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              IconsAssets.news,
              color: AppColors.inactiveIconColor,
            ),
            activeItem: SvgPicture.asset(
              IconsAssets.news,
              color: AppColors.primaryColor,
            ),
          ),
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              IconsAssets.chat,
              color: AppColors.inactiveIconColor,
            ),
            activeItem: SvgPicture.asset(
              IconsAssets.chat,
              color: AppColors.primaryColor,
            ),
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
      // Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20.r),
      //       topRight: Radius.circular(20.r),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withAlpha(50),
      //         blurRadius: 10.r,
      //         offset: const Offset(0, -4),
      //       ),
      //     ],
      //   ),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20.r),
      //       topRight: Radius.circular(20.r),
      //     ),
      //     child: BottomNavigationBar(
      //       type: BottomNavigationBarType.fixed,
      //       elevation: 0,
      //       backgroundColor: AppColors.white,
      //       showSelectedLabels: false,
      //       showUnselectedLabels: false,
      //       currentIndex: _currentIndex,
      //       onTap: (index) {
      //         setState(() {
      //           _currentIndex = index;
      //         });
      //       },
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: CustomIconBottomNav(
      //             icon: IconsAssets.home,
      //             isSelected: _currentIndex == 0,
      //           ),
      //           label: "Home",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: CustomIconBottomNav(
      //             icon: IconsAssets.favorite,
      //             isSelected: _currentIndex == 1,
      //           ),
      //           label: "Favorites",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: CustomIconBottomNav(
      //             icon: IconsAssets.news,
      //             isSelected: _currentIndex == 2,
      //           ),
      //           label: "News",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: CustomIconBottomNav(
      //             icon: IconsAssets.chat,
      //             isSelected: _currentIndex == 3,
      //           ),
      //           label: "Chat",
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
