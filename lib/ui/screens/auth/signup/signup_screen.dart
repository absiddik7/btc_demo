import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/auth/signup_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/env.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/core/utils/navigation_helper.dart';
import 'package:mybtccanvas/ui/screens/auth/signin/signin_screen.dart';
import 'package:mybtccanvas/ui/screens/auth/signup/set_password.dart';
import 'package:mybtccanvas/ui/screens/settings/web_view/web_view_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_input_field.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/social_media_button.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignupProvider>().setFullnameEmailValidationStarted(false);
    });
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<ThemeProvider, SignupProvider>(
          builder: (context, themeProvider, signupProvider, _) {
            final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;
            final Color secondaryTextColor = themeProvider.currentTheme.textSecondaryColor;
            final Color appThirdColor = themeProvider.currentTheme.appThirdColor;

            return Column(
              children: [
                // app bar
                const CustomAppBar(title: ''),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // title section
                          _buildTitleSection(primaryTextColor),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // form section
                          _buildFormSection(signupProvider),
                          const SizedBox(height: SizeConstant.spaceSmall),

                          _termsAndPrivecyPolicyText(themeProvider),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // sign up button
                          _buildSignUpNextButton(signupProvider),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // or divider
                          _buildOrDivider(secondaryTextColor),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // social sign up buttons
                          _buildSocialSignUpButtons(signupProvider),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // sign in link
                          _buildSignInLink(secondaryTextColor, appThirdColor),
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
        context.lang.signup_title,
        style: AppTextStyles.outfitSB40(color: primaryTextColor),
      ),
    );
  }

  // form section
  Widget _buildFormSection(SignupProvider signupProvider) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // name input field
          CustomInputField(
            hintText: context.lang.name,
            validator: (value) => signupProvider.nameValidator(context, value),
            controller: nameController,
            prefixIcon: AppAssets.nameIcon,
            onChanged: (value) {
              // Trigger form validation when name is changed
              if (signupProvider.isFullnameEmailValidationStarted) {
                _formKey.currentState!.validate();
              }
            },
          ),
          const SizedBox(height: SizeConstant.spaceLarge),
          // email input field
          CustomInputField(
            hintText: context.lang.email,
            validator: (value) => signupProvider.emailValidator(context, value),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: AppAssets.emailIcon,
            onChanged: (value) {
              // Trigger form validation when email is changed
              if (signupProvider.isFullnameEmailValidationStarted) {
                _formKey.currentState!.validate();
              }
            },
          ),
        ],
      ),
    );
  }

  // sign up button
  Widget _buildSignUpNextButton(SignupProvider signupProvider) {
    return SizedBox(
      width: double.infinity,
      child: CommonButton(
        type: ButtonType.primary,
        label: context.lang.next,
        onPressed: () {
          // Set the password validation started to true
          signupProvider.setFullnameEmailValidationStarted(true);

          if (_formKey.currentState!.validate()) {
            // unfocus
            FocusScope.of(context).unfocus();
            // Splitting the full name
            String fullName = nameController.text.trim();
            List<String> nameParts = fullName.split(RegExp(r'\s+')); // Split by spaces

            String firstName = '';
            String lastName = '';

            // Check if the name has more than one word
            if (nameParts.length > 1) {
              // Last word as lastName
              lastName = nameParts.last;
              
              // All words before the last word as firstName
              firstName = nameParts.sublist(0, nameParts.length - 1).join(' ');
            } else {
              // If there is only one word, it is treated as firstName
              firstName = nameParts.first;
              lastName = ' '; // No last name
            }
            print('First Name: $firstName, Last Name: $lastName');

            NavigationHelper.navigateTo(context, SetPasswordScreen(
              firstName: firstName,
              lastName: lastName,
              email: emailController.text,
            ));
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
        Text(
          context.lang.or,
          style: AppTextStyles.outfitR16(color: secondaryTextColor),
        ),
      ],
    );
  }

  // social sign up buttons
  Widget _buildSocialSignUpButtons(SignupProvider signupProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: SocialMediaButton(type: SocialMediaType.apple, onPressed: () {})),
        const SizedBox(width: SizeConstant.spaceExtraSmall),
        Expanded(
          child: SocialMediaButton(type: SocialMediaType.google, onPressed: () async {
            try {
              await signupProvider.signInWithGoogle();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Signed in as ${signupProvider.user?.displayName}')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sign-in failed: $e')),
              );
            }
          }),
        ),
        const SizedBox(width: SizeConstant.spaceExtraSmall),
        Expanded(child: SocialMediaButton(type: SocialMediaType.facebook, onPressed: () {})),
      ],
    );
  }

  // sign in link
  Widget _buildSignInLink(Color secondaryTextColor, Color appThirdColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.lang.already_have_account,
          style: AppTextStyles.outfitR16(color: secondaryTextColor),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const SigninScreen()),
            );
          },
          child: Text(
            " ${context.lang.login}",
            style: AppTextStyles.outfitR16(color: appThirdColor),
          ),
        ),
      ],
    );
  }

  Widget _termsAndPrivecyPolicyText(ThemeProvider themeProvider) {
    return RichText(
      text: TextSpan(
        text: 'By continuing you agree to ',
        style: AppTextStyles.outfitR16(color: themeProvider.currentTheme.textSecondaryColor),
        children: [
          TextSpan(
            text: 'Privacy Policy',
            style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.appThirdColor),
            recognizer: TapGestureRecognizer()..onTap = _openPrivacyPolicy,
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Terms of Service',
            style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.appThirdColor),
            recognizer: TapGestureRecognizer()..onTap = _openTermsOfService,
          ),
        ],
      ),
    );
  }

  void _openPrivacyPolicy() {
    // Replace with your logic to navigate or open a URL
    debugPrint('Privacy Policy clicked');
    Navigator.of(context).push(CupertinoPageRoute(
    builder: (context) => WebViewScreen(
          title: context.lang.privacy_policy,
          webUrl: privacyPolicyUrl,
        )));
  }

  void _openTermsOfService() {
    // Replace with your logic to navigate or open a URL
    debugPrint('Terms of Service clicked');
    Navigator.of(context).push(CupertinoPageRoute(
    builder: (context) => WebViewScreen(
          title: context.lang.privacy_policy,
          webUrl: privacyPolicyUrl,
        )));
  }
}
