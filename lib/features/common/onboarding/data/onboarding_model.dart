import '../../../../generated/image_assets.dart';

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
      description:
          'Discover a wide network of certified and experienced medical professionals ready to provide top-quality healthcare for you and your family.',
    ),
    OnboardingModel(
      image: ImageAssets.onBoarding5,
      title: 'Choose Best Doctors',
      description:
          'Review detailed doctor profiles, read genuine patient feedback, and select the perfect specialist who meets your specific health and medical needs.',
    ),
    OnboardingModel(
      image: ImageAssets.onBoarding3,
      title: 'Easy Appointments',
      description:
          'Schedule your clinic visits instantly with our seamless booking system, saving you valuable time and avoiding long waiting room queues.',
    ),
  ];
}
