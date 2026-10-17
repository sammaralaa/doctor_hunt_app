import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/controller/menu_drawer_bloc.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/controller/menu_drawer_event.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/widgets/custom_animated_drawer.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  late final NotchBottomBarController _controller;
  final GlobalKey<CustomAnimatedDrawerState> _drawerKey =
      GlobalKey<CustomAnimatedDrawerState>();
  final int maxCount = 4;

  @override
  void initState() {
    super.initState();
    _controller = NotchBottomBarController(
      index: widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigationShell.currentIndex != _controller.index) {
      _controller.jumpTo(widget.navigationShell.currentIndex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMenuItemSelected(int index) {
    if (index >= 0 && index < maxCount) {
      widget.navigationShell.goBranch(index);
      _controller.jumpTo(index);
      _drawerKey.currentState?.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuDrawerBloc>(
      create: (context) =>
          getIt<MenuDrawerBloc>()..add(const LoadMenuDrawerDataEvent()),
      child: CustomAnimatedDrawer(
        key: _drawerKey,
        selectedIndex: widget.navigationShell.currentIndex,
        onMenuItemSelected: _onMenuItemSelected,
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              const TopLeftShadowWidget(),
              const BottomRightShadowWidget(),
              widget.navigationShell,
            ],
          ),
          bottomNavigationBar: AnimatedNotchBottomBar(
            notchBottomBarController: _controller,
            bottomBarItems: [
              BottomBarItem(
                inActiveItem: SvgPicture.asset(
                  IconsAssets.home,
                  colorFilter: const ColorFilter.mode(
                    AppColors.inactiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeItem: SvgPicture.asset(
                  IconsAssets.home,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomBarItem(
                inActiveItem: SvgPicture.asset(
                  IconsAssets.favorite,
                  colorFilter: const ColorFilter.mode(
                    AppColors.inactiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeItem: SvgPicture.asset(
                  IconsAssets.favorite,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomBarItem(
                inActiveItem: SvgPicture.asset(
                  IconsAssets.appoinment,
                  colorFilter: const ColorFilter.mode(
                    AppColors.inactiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeItem: SvgPicture.asset(
                  IconsAssets.appoinment,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const BottomBarItem(
                inActiveItem: Icon(
                  Icons.settings,
                  color: AppColors.inactiveIconColor,
                ),
                activeItem: Icon(
                  Icons.settings,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
            onTap: (int value) {
              widget.navigationShell.goBranch(value);
            },
            kIconSize: 20,
            kBottomRadius: 20,
          ),
        ),
      ),
    );
  }
}

