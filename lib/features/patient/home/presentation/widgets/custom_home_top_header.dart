import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_bloc.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_state.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CustomHomeTopHeader extends StatefulWidget {
  final TextEditingController? searchController;
  final String userName;
  final String? profileImageUrl;
  final VoidCallback? onProfileImageTap;
  final VoidCallback? onSearchTap;
  final bool isLoading;

  const CustomHomeTopHeader({
    super.key,
    this.searchController,
    required this.userName,
    this.onProfileImageTap,
    this.onSearchTap,
    this.profileImageUrl,
    required this.isLoading,
  });

  @override
  State<CustomHomeTopHeader> createState() => _CustomHomeTopHeaderState();
}

class _CustomHomeTopHeaderState extends State<CustomHomeTopHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpace(15),
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        current is UserProfileLoadingState ||
                        current is UserProfileSuccessState ||
                        current is UserProfileFailureState,
                    builder: (context, state) {
                      final bool isNameLoading =
                          state is UserProfileLoadingState ||
                          widget.isLoading ||
                          (widget.userName.isEmpty &&
                              state is! UserProfileSuccessState);

                      if (isNameLoading) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Shimmer.fromColors(
                            baseColor: AppColors.white.withValues(alpha: 0.3),
                            highlightColor:
                                AppColors.white.withValues(alpha: 0.6),
                            child: Container(
                              width: 120,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      }

                      final name = state is UserProfileSuccessState
                          ? state.user.name
                          : widget.userName;

                      return Text(
                        t.hi(userName: name),
                        style: context.regular20White,
                      );
                    },
                  ),
                  Text(t.findYourDoctor, style: context.bold26White),
                  HeightSpace(30),
                ],
              ),
              GestureDetector(
                onTap: widget.onProfileImageTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: widget.isLoading
                      ? Shimmer.fromColors(
                          baseColor: AppColors.white.withValues(alpha: 0.3),
                          highlightColor:
                              AppColors.white.withValues(alpha: 0.6),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : widget.profileImageUrl != null &&
                            widget.profileImageUrl!.isNotEmpty
                      ? Image.network(
                          widget.profileImageUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                ImageAssets.onBoarding5,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                        )
                      : Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.inactiveBorderColor.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 40,
                            color: AppColors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 20,
          right: 20,
          bottom: -24,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: widget.searchController,
              readOnly: true,
              onTap: widget.onSearchTap ??
                  () => const SearchRoute().push(context),
              decoration: InputDecoration(
                hintText: t.search,
                hintStyle: context.regular16TextSub,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.subtitleColor,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.subtitleColor),
                  onPressed: () {
                    //searchController.clear();
                  },
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
