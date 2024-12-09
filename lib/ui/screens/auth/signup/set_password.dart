import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/auth/signup_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/core/utils/message_service.dart';
import 'package:mybtccanvas/core/utils/navigation_helper.dart';
import 'package:mybtccanvas/ui/screens/auth/check_email/check_email_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/loading_screen.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/password_input_field.dart';
import 'package:provider/provider.dart';

class SetPasswordScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  const SetPasswordScreen({super.key, required this.firstName, required this.lastName, required this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignupProvider>().setPasswordValidationStarted(false);
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<ThemeProvider, SignupProvider>(
          builder: (context, themeProvider, signupProvider, _) {
            final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;

            return Column(
              children: [
                // app bar
                const CustomAppBar(title: ''),
                // main content
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
                          _buildTitle(primaryTextColor),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // password form
                          _buildPasswordForm(signupProvider),
                          const SizedBox(height: SizeConstant.spaceLarge),
                        ],
                      ),
                    ),
                  ),
                ),

                // sign up button
                _buildSignUpButton(context, signupProvider),
              ],
            );
          },
        ),
      ),
    );
  }

  // title section
  Widget _buildTitle(Color primaryTextColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        context.lang.set_password,
        style: AppTextStyles.outfitSB40(color: primaryTextColor),
      ),
    );
  }

  // password form
  Widget _buildPasswordForm(SignupProvider signupProvider) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // password input field
          PasswordInputField(
            controller: passwordController,
            hintText: context.lang.password,
            validator: (value) => signupProvider.passwordValidator(context, value),
          ),
          const SizedBox(height: SizeConstant.spaceLarge),

          // confirm password input field
          PasswordInputField(
            controller: confirmPasswordController,
            hintText: context.lang.confirm_password,
            validator: (value) => signupProvider.confirmPasswordValidator(context, value, passwordController.text),
            onChanged: (value) {
              // Trigger form validation when confirm password is changed
              if(signupProvider.isPasswordsValidationStarted) {
                _formKey.currentState!.validate();
              }
            },
          ),
        ],
      ),
    );
  }

  // sign up button
  Widget _buildSignUpButton(BuildContext context, SignupProvider signupProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      child: CommonButton(
        type: ButtonType.primary,
        label: context.lang.signup,
        onPressed: () async{
          // Set the password validation started to true
          signupProvider.setPasswordValidationStarted(true);

          // Unfocus all text fields to close the keyboard
          FocusScope.of(context).unfocus();
          
          if (_formKey.currentState!.validate()) {
            showAppLoading(context); // Hide loading dialog
            // Create a User Map
            Map<String, String> userData = {
              "firstName": widget.firstName,
              "lastName": widget.lastName,
              "email": widget.email,
              "password": passwordController.text.trim(),
            };

            // Print the map for debugging
            print(userData);

            // Call the register method from the signup provider
            try {
              await signupProvider.registerUser(context, userData);
              MessageService.showSuccess(context, signupProvider.userModel!.message);
              hideAppLoading(context);

              NavigationHelper.navigateTo(context, const CheckEmailScreen());
            } catch (e) {
              // Handle errors, show message, etc.
              print("Error during registration: $e");

              // Show error message
              MessageService.showError(context, e.toString());
              hideAppLoading(context);
            }
          }
        },
      ),
    );
  }
}
