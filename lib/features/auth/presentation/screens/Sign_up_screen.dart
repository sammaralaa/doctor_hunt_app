import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/features/auth/data/repos/auth_repository.dart';
import 'package:doctor_hunt_app/features/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt_app/features/auth/presentation/controller/auth_events.dart';
import 'package:doctor_hunt_app/features/auth/presentation/controller/auth_state.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/bottom_right_shadow_widget.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../../../../core/widgets/top_left_shadow_widget.dart';
import '../widgets/custom_textfeild_widget.dart';
import '../widgets/login_with_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  bool ispassword = true;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController nameController;
  bool isAccepted = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: Scaffold(
        body: Stack(
          children: [
            TopLeftShadowWidget(),
            BottomRightShadowWidget(),
            SafeArea(
              child: LayoutBuilder(
                builder: ((context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              HeightSpace(100),
                              Text(
                                t.joinUs,
                                style: context.bold26TextMain,
                              ),
                              HeightSpace(15),
                              Text(
                                "You can search c ourse, apply course and findscholarship for abroad studies",
                                style: context.regular14TextSub,
                                textAlign: TextAlign.center,
                              ),
                              HeightSpace(60),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LoginWithWidget(
                                    btnText: t.google,
                                    onTop: () {},
                                    btnIcon: SvgPicture.asset(
                                      IconsAssets.googleIcon,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  WidthSpace(15),
                                  LoginWithWidget(
                                    btnText: t.facebook,
                                    onTop: () {},
                                    btnIcon: SvgPicture.asset(
                                      IconsAssets.facebookIcon,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                ],
                              ),
                              HeightSpace(34),
                              CustomTextfeildWidget(
                                hintText: t.name,
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return t.enterYourName;
                                  }
                                  return null;
                                },
                              ),
                              HeightSpace(18),
                              CustomTextfeildWidget(
                                hintText: t.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return t.enterYourEmail;
                                  }
                                  return null;
                                },
                                controller: emailController,
                              ),
                              HeightSpace(18),
                              CustomTextfeildWidget(
                                hintText: t.password,
                                isPassWord: ispassword,
                                controller: passController,
                                suffixIcon: IconButton(
                                  icon: ispassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  color: AppColors.subtitleColor,
                                  onPressed: () {
                                    setState(() {
                                      ispassword = !ispassword;
                                    });
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return t.enterYourPassword;
                                  }
                                  if (value.length < 8) {
                                    return t.passwordMustBe;
                                  }
                                  return null;
                                },
                              ),
                              HeightSpace(14),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isAccepted,
                                    shape: const CircleBorder(),
                                    activeColor: AppColors.primaryColor,
                                    side: const BorderSide(
                                      color: AppColors.inactiveBorderColor,
                                      width: 1.5,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isAccepted = value ?? false;
                                      });
                                    },
                                  ),
                                  WidthSpace(11),
                                  Text(
                                    t.iAgreeWithTheTerms,
                                    style: context.regular12TextSub,
                                  ),
                                ],
                              ),
                              //Spacer(),
                              BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Account created successfully!",
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                    );
                                    MainScreenRoute().go(context);
                                  } else if (state is AuthFailure) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.errorMessage),
                                        backgroundColor: AppColors.red,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return const CircularProgressIndicator();
                                  }
                                  return CustomElevatdButton(
                                    buttonTXT: t.signUp,
                                    onTap: () {
                                      if (!isAccepted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Please accept the Terms & Privacy Policy",
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        context.read<AuthBloc>().add(
                                         SignUpRequestedEvent(
                                                email: emailController.text
                                                    .trim(),
                                                password: passController.text
                                                    .trim(),
                                                name: nameController.text
                                                    .trim(),
                                              ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    t.haveAnAccount,
                                    style: context.regular14Primary,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      t.logIn,
                                      style: context.regular14Primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
