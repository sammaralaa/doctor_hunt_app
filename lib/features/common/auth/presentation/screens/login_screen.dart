import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/services/shared_prefs_service.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_events.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_state.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/widgets/custom_textfeild_widget.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/widgets/login_with_widget.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/forgot_password_widget.dart';

class LoginScreen extends StatefulWidget {
  final String? userRole;
  const LoginScreen({super.key, this.userRole});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  bool ispassword = true;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;
  bool isAccepted = false;
  @override
  void initState() {
    super.initState();
    SharedPrefsService.init();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        body: Stack(
          children: [
            TopLeftShadowWidget(),
            BottomRightShadowWidget(),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                HeightSpace(100),
                                Text(
                                  t.welcomeBack,
                                  style: context.bold26TextMain,
                                ),
                                HeightSpace(15),
                                Text(
                                  "You can search c ourse, apply course and findscholarship for abroad studies",
                                  style: context.regular14TextSub,
                                  textAlign: TextAlign.center,
                                ),
                                HeightSpace(60),
                                widget.userRole != "admin"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          LoginWithWidget(
                                            btnText: t.google,
                                            onTop: () {},
                                            btnIcon: SvgPicture.asset(
                                              IconsAssets.googleIcon,
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(),
                                HeightSpace(34),
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
                                  controller: passController,
                                  isPassWord: ispassword,
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
                                HeightSpace(32),
                                BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthSuccess) {
                                      if (state.role == widget.userRole) {
                                        SharedPrefsService.setBool('is_logged_in', true);
                                        SharedPrefsService.setString('user_role', state.role);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              t.logedInSuccessfully,
                                            ),
                                            backgroundColor:
                                                AppColors.primaryColor,
                                          ),
                                        );

                                        if (state.role == 'admin') {
                                          AdminMainRoute().go(context);
                                        } else {
                                          MainScreenRoute().go(context);
                                        }
                                      } else {
                                        context.read<AuthBloc>().add(
                                          SignOutRequestedEvent(),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Access denied. This account is registered as a Patient, not an Admin.",
                                            ),
                                            backgroundColor: AppColors.red,
                                          ),
                                        );
                                        ChooseRoleRoute().go(context);
                                      }
                                    } else if (state is AuthFailure) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
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
                                      buttonTXT: t.logIn,
                                      onTap: () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          context.read<AuthBloc>().add(
                                            LogInRequestedEvent(
                                              email: emailController.text
                                                  .trim(),
                                              password: passController.text
                                                  .trim(),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),

                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                        ),
                                      ),
                                      builder: (context) =>
                                          ForgotPasswordWidget(),
                                    );
                                  },
                                  child: Text(
                                    t.forgotPassword,
                                    style: context.regular14Primary,
                                  ),
                                ),
                                //HeightSpace(60),
                                Spacer(),
                                widget.userRole != "admin"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            t.donTHaveAnAccount,
                                            style: context.regular14Primary,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ChooseRoleRoute().go(context);
                                            },
                                            child: Text(
                                              t.joinUs,
                                              style: context.regular14Primary,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
