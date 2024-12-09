import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/auth/signin_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/core/utils/message_service.dart';
import 'package:mybtccanvas/core/utils/navigation_helper.dart';
import 'package:mybtccanvas/ui/screens/auth/forgot_password_send_email/forgot_password_send_email_screen.dart';
import 'package:mybtccanvas/ui/screens/auth/signup/signup_screen.dart';
import 'package:mybtccanvas/ui/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:mybtccanvas/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_input_field.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/loading_screen.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/password_input_field.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/social_media_button.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignInProvider>().setEmailValidationStarted(false);
      context.read<SignInProvider>().setPasswordValidationStarted(false);
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<ThemeProvider, SignInProvider>(
          builder: (context, themeProvider, signinProvider, _) {
            final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;
            final Color secondaryTextColor = themeProvider.currentTheme.textSecondaryColor;
            final Color appThirdColor = themeProvider.currentTheme.appThirdColor;

            return Column(
              children: [
                // app bar
                CustomAppBar(
                  title: '',
                  onBackButtonPressed: () {
                    NavigationHelper.navigateToReplacement(context, const WelcomeScreen());
                  },
                ),
                // body
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title Section
                          _buildTitleSection(primaryTextColor),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // Form Section
                          _buildFormSection(signinProvider),
                          const SizedBox(height: SizeConstant.spaceSmall),

                          // Forgot Password Link
                          _buildForgotPasswordLink(appThirdColor),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // Sign-In Button
                          _buildSignInButton(context, signinProvider),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // Or Divider
                          _buildOrDivider(secondaryTextColor),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // Social Sign-In Buttons
                          _buildSocialSignInButtons(signinProvider),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // Sign-Up Link
                          _buildSignUpLink(secondaryTextColor, appThirdColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // title section
  Widget _buildTitleSection(Color primaryTextColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        context.lang.login_title,
        style: AppTextStyles.outfitSB40(color: primaryTextColor),
      ),
    );
  }

  // email and password form section
  Widget _buildFormSection(SignInProvider signinProvider) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Input Field
          CustomInputField(
            hintText: context.lang.email,
            controller: emailController,
            prefixIcon: AppAssets.emailIcon,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => signinProvider.emailValidator(context, value),
            onChanged: (value) {
              // Trigger form validation when name is changed
              if (signinProvider.isEmailValidationStarted) {
                _formKey.currentState!.validate();
              }
            },
          ),
          const SizedBox(height: SizeConstant.spaceLarge),
          // Password Input Field
          PasswordInputField(
            controller: passwordController,
            hintText: context.lang.password,
            validator: (value) => signinProvider.passwordValidator(context, value),
            onChanged: (value) {
              // Trigger form validation when confirm password is changed
              if (signinProvider.isPasswordsValidationStarted) {
                _formKey.currentState!.validate();
              }
            },
          ),
        ],
      ),
    );
  }

  // forgot password link
  Widget _buildForgotPasswordLink(Color appThirdColor) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          NavigationHelper.navigateTo(context, const ForgotPasswordSendEmailScreen());
        },
        child: Text(
          '${context.lang.forgot_password}?',
          style: AppTextStyles.outfitSB16(color: appThirdColor),
        ),
      ),
    );
  }

  // sign-in button
  Widget _buildSignInButton(BuildContext context, SignInProvider signInProvider) {
    return SizedBox(
      width: double.infinity,
      child: CommonButton(
        type: ButtonType.primary,
        label: context.lang.login,
        onPressed: () async {
          // Multiple methods to dismiss keyboard
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();

          signInProvider.setEmailValidationStarted(true);
          signInProvider.setPasswordValidationStarted(true);
          if (_formKey.currentState!.validate()) {
            showAppLoading(context);
            try {
              await signInProvider.loginUser(
                context,
                emailController.text.trim(),
                passwordController.text.trim(),
              );
              if (!context.mounted) return;
              hideAppLoading(context);
              // Navigate to the home screen
              NavigationHelper.navigateToReplacement(context, const BottomBarScreen());
            } catch (e) {
              hideAppLoading(context);
              // Show error to the user
              MessageService.showError(context, e.toString());
            }
          }
        },
      ),
    );
  }

  // or divider
  Widget _buildOrDivider(Color secondaryTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeConstant.paddingSmall),
          child: Text(
            "or",
            style: AppTextStyles.outfitR16(color: secondaryTextColor),
          ),
        ),
      ],
    );
  }

  // social sign-in buttons
  Widget _buildSocialSignInButtons(SignInProvider signInProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Apple Sign-In Button
        Expanded(
            child: SocialMediaButton(
                type: SocialMediaType.apple,
                onPressed: () {
                  try {
                    signInProvider.signInWithApple().then((value) {
                      if (!context.mounted) return;
                      // Show success message
                      MessageService.showSuccess(context, 'Signed in as ${signInProvider.user?.displayName}');
                      // Navigate to the home screen
                      NavigationHelper.navigateToReplacement(context, const BottomBarScreen());
                    });
                  } catch (e) {
                    // Show error message
                    MessageService.showError(context, 'Sign-in failed');
                  }
                })),
        const SizedBox(width: SizeConstant.spaceSmall),
        // Google Sign-In Button
        Expanded(
            child: SocialMediaButton(
                type: SocialMediaType.google,
                onPressed: () async {
                  showAppLoading(context);
                  try {
                    await signInProvider.loginUserWithSocial(context, signInProvider.signInWithGoogle).then((value) {
                      if (!context.mounted) return;
                      // Show success message
                      MessageService.showSuccess(context, 'Signed in as ${signInProvider.user?.displayName}');
                      // Navigate to the home screen
                      hideAppLoading(context);
                      NavigationHelper.navigateToReplacement(context, const BottomBarScreen());
                    });
                  } catch (e) {
                    // Show error message
                    hideAppLoading(context);
                    MessageService.showError(context, 'Sign-in failed');
                  }
                })),
        const SizedBox(width: SizeConstant.spaceSmall),
        // Facebook Sign-In Button
        Expanded(child: SocialMediaButton(type: SocialMediaType.facebook, onPressed: () {})),
      ],
    );
  }

  // sign-up link
  Widget _buildSignUpLink(Color secondaryTextColor, Color appThirdColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.lang.dont_have_account,
          style: AppTextStyles.outfitR16(color: secondaryTextColor),
        ),
        // Navigate to the sign-up screen
        GestureDetector(
          onTap: () {
            NavigationHelper.navigateTo(context, const SignupScreen());
          },
          child: Text(
            " ${context.lang.signup}",
            style: AppTextStyles.outfitR16(color: appThirdColor),
          ),
        ),
      ],
    );
  }
}
