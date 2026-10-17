import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/utils/debouncer.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/widgets/popular_doctor_card_widget.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/presentation/controller/search_doctors_bloc.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/presentation/controller/search_doctors_event.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/presentation/controller/search_doctors_state.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/presentation/widgets/search_shimmer_card.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const TopLeftShadowWidget(),
          const BottomRightShadowWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const HeightSpace(10),
                  _buildSearchBar(context),
                  const HeightSpace(16),
                  Expanded(
                    child: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
                      builder: (context, state) {
                        if (state is SearchDoctorsLoadingState) {
                          return _buildLoadingShimmer();
                        }
                        if (state is SearchDoctorsEmptyState) {
                          return _buildEmptyState(context);
                        }
                        if (state is SearchDoctorsErrorState) {
                          return _buildErrorState(context, state.errorMessage);
                        }
                        if (state is SearchDoctorsLoadedState) {
                          return _buildResultsList(context, state.doctors);
                        }
                        return _buildInitialPrompt(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.pop(),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: AppColors.titleColor,
            ),
          ),
        ),
        const WidthSpace(12),
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {});
                _debouncer.run(() {
                  if (mounted) {
                    context
                        .read<SearchDoctorsBloc>()
                        .add(SearchQueryChangedEvent(value));
                  }
                });
              },
              decoration: InputDecoration(
                hintText: t.searchDoctors,
                hintStyle: context.regular14TextSub,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.subtitleColor,
                  size: 22,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.subtitleColor,
                          size: 20,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                          _debouncer.cancel();
                          context
                              .read<SearchDoctorsBloc>()
                              .add(const ClearSearchEvent());
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialPrompt(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_search_rounded,
                size: 44,
                color: AppColors.primaryColor,
              ),
            ),
            const HeightSpace(20),
            Text(
              t.searchDoctorsTitle,
              style: context.bold18TextMain,
              textAlign: TextAlign.center,
            ),
            const HeightSpace(8),
            Text(
              t.searchForDoctorsPrompt,
              style: context.regular14TextSub,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemCount: 6,
      itemBuilder: (context, index) => const SearchShimmerCard(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 44,
                color: AppColors.red,
              ),
            ),
            const HeightSpace(20),
            Text(
              t.noDoctorsFound,
              style: context.bold18TextMain,
              textAlign: TextAlign.center,
            ),
            const HeightSpace(8),
            Text(
              t.noDoctorsFoundDesc,
              style: context.regular14TextSub,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.red,
            ),
            const HeightSpace(16),
            Text(
              message,
              style: context.regular14TextSub,
              textAlign: TextAlign.center,
            ),
            const HeightSpace(16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.read<SearchDoctorsBloc>().add(
                  SearchQueryChangedEvent(_searchController.text),
                );
              },
              child: Text(
                t.retry,
                style: context.regular14White,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(BuildContext context, List<DoctorModel> doctors) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return PopularDoctorCardWidget(
          doctor: doctor,
          onTap: () {
            DoctorDetailsRoute(doctorId: doctor.id ?? '').push(context);
          },
        );
      },
    );
  }
}
