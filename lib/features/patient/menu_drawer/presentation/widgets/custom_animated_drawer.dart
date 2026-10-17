import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/app_logout_dialog.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/controller/menu_drawer_bloc.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/controller/menu_drawer_event.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/controller/menu_drawer_state.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'menu_drawer_content.dart';

class CustomAnimatedDrawerScope extends InheritedWidget {
  final VoidCallback openDrawer;
  final VoidCallback closeDrawer;
  final VoidCallback toggleDrawer;
  final bool isDrawerOpen;

  const CustomAnimatedDrawerScope({
    super.key,
    required this.openDrawer,
    required this.closeDrawer,
    required this.toggleDrawer,
    required this.isDrawerOpen,
    required super.child,
  });

  static CustomAnimatedDrawerScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomAnimatedDrawerScope>();
  }

  @override
  bool updateShouldNotify(CustomAnimatedDrawerScope oldWidget) {
    return isDrawerOpen != oldWidget.isDrawerOpen;
  }
}

class CustomAnimatedDrawer extends StatefulWidget {
  final Widget child;
  final ValueChanged<int> onMenuItemSelected;
  final int selectedIndex;

  const CustomAnimatedDrawer({
    super.key,
    required this.child,
    required this.onMenuItemSelected,
    this.selectedIndex = 0,
  });

  @override
  State<CustomAnimatedDrawer> createState() => CustomAnimatedDrawerState();
}

class CustomAnimatedDrawerState extends State<CustomAnimatedDrawer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void openDrawer() {
    if (!_isOpen) {
      context.read<MenuDrawerBloc>().add(const LoadMenuDrawerDataEvent());
      _animationController.forward();
      setState(() {
        _isOpen = true;
      });
    }
  }

  void closeDrawer() {
    if (_isOpen) {
      _animationController.reverse();
      setState(() {
        _isOpen = false;
      });
    }
  }

  void toggleDrawer() {
    if (_isOpen) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }

  void _onMenuItemTapped(int index) {
    closeDrawer();
    widget.onMenuItemSelected(index);
  }

  void _onLogoutTapped(BuildContext context) {
    showLogoutConfirmationDialog(
      context: context,
      onConfirm: () {
        context.read<MenuDrawerBloc>().add(const MenuLogoutEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocListener<MenuDrawerBloc, MenuDrawerState>(
      listener: (context, state) {
        if (state is MenuLogoutSuccessState) {
          const ChooseRoleRoute().go(context);
        } else if (state is MenuLogoutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: context.regular14White,
              ),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: PopScope(
        canPop: !_isOpen,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && _isOpen) {
            closeDrawer();
          }
        },
        child: CustomAnimatedDrawerScope(
          openDrawer: openDrawer,
          closeDrawer: closeDrawer,
          toggleDrawer: toggleDrawer,
          isDrawerOpen: _isOpen,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.drawerBackgroundStart,
                  AppColors.drawerBackgroundEnd,
                ],
              ),
            ),
            child: Stack(
              children: [
                // 1. Menu Drawer Content underneath
                SizedBox(
                  width: size.width * 0.70,
                  height: size.height,
                  child: BlocBuilder<MenuDrawerBloc, MenuDrawerState>(
                    builder: (context, state) {
                      final patient = (state is MenuDrawerLoadedState)
                          ? state.patient
                          : null;
                      return MenuDrawerContent(
                        patient: patient,
                        selectedIndex: widget.selectedIndex,
                        onItemSelected: _onMenuItemTapped,
                        onLogoutTap: () => _onLogoutTapped(context),
                      );
                    },
                  ),
                ),

                // 2. 3D Animated Screen Stack
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final slide = _animation.value;

                    // Layer 1: Behind card (3D perspective slice)
                    final shadowScale = 1.0 - (slide * 0.34);
                    final shadowX = slide * (size.width * 0.52);
                    final shadowRadius = slide * 30.0;

                    // Layer 2: Main screen card
                    final mainScale = 1.0 - (slide * 0.28);
                    final mainX = slide * (size.width * 0.62);
                    final mainRadius = slide * 30.0;

                    return Stack(
                      children: [
                        // Secondary 3D layer
                        if (slide > 0.01)
                          Transform.translate(
                            offset: Offset(shadowX, 0),
                            child: Transform.scale(
                              scale: shadowScale,
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: size.width,
                                height: size.height,
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.16),
                                  borderRadius: BorderRadius.circular(shadowRadius),
                                ),
                              ),
                            ),
                          ),

                        // Main screen
                        Transform.translate(
                          offset: Offset(mainX, 0),
                          child: Transform.scale(
                            scale: mainScale,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(mainRadius),
                                boxShadow: slide > 0.01
                                    ? [
                                        BoxShadow(
                                          color: AppColors.black.withValues(
                                            alpha: 0.22 * slide,
                                          ),
                                          blurRadius: 28,
                                          offset: const Offset(-8, 10),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(mainRadius),
                                child: Stack(
                                  children: [
                                    widget.child,
                                    if (slide > 0.01)
                                      Positioned.fill(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: closeDrawer,
                                          onHorizontalDragUpdate: (details) {
                                            if (details.primaryDelta != null &&
                                                details.primaryDelta! < -6) {
                                              closeDrawer();
                                            }
                                          },
                                          child: Container(
                                            color: AppColors.transparent,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
