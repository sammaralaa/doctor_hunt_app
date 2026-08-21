import '../../../generated/image_assets.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static const List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: ImageAssets.onBoarding1,
      title: 'Find Trusted Doctors',
      description: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
    ),
    OnboardingModel(
      image: ImageAssets.onBoarding5,
      title: 'Choose Best Doctors',
      description: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
    ),
    OnboardingModel(
      image: ImageAssets.onBoarding3,
      title: 'Easy Appointments',
      description: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
    ),
  ];
}