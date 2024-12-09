import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/password_input_field.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:mybtccanvas/core/providers/auth/change_password_provider.dart';
import 'package:mybtccanvas/ui/screens/auth/forgot_password_send_email/forgot_password_send_email_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    currentPasswordController.addListener(_checkFormValidity);
    newPasswordController.addListener(_checkFormValidity);
    confirmNewPasswordController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    bool isValid = currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty;

    // Update the button enabled state in the provider
    Provider.of<ChangePasswordProvider>(context, listen: false).setButtonEnabled(isValid);
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ThemeProvider, ChangePasswordProvider>(
        builder: (context, themeProvider, changePasswordProvider, _) {
          return CustomBackground(
            child: Column(
              children: [
                // appBars
                CustomAppBar(title: context.lang.password),
                // form section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                    child: SingleChildScrollView(
                      child: _buildPasswordInputForm(context, changePasswordProvider),
                    ),
                  ),
                ),
                // button section
                _buildButtonSection(context, changePasswordProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  // Password Input Fields Form
  Widget _buildPasswordInputForm(BuildContext context, ChangePasswordProvider provider) {
    return Form(
      key: provider.formKey,
      child: Column(
        children: [
          // Current Password
          PasswordInputField(
            hintText: context.lang.current_password,
            validator: (value) => provider.currentPasswordValidator(context, value),
            controller: currentPasswordController,
          ),
          const SizedBox(height: SizeConstant.spaceLarge),
          // New Password
          PasswordInputField(
            hintText: context.lang.new_password,
            validator: (value) => provider.passwordValidator(context, value),
            controller: newPasswordController,
          ),
          const SizedBox(height: SizeConstant.spaceLarge),
          // Confirm New Password
          PasswordInputField(
            hintText: context.lang.confirm_new_password,
            validator: (value) => provider.confirmPasswordValidator(
              context,
              value,
              newPasswordController.text,
            ),
            controller: confirmNewPasswordController,
          ),
        ],
      ),
    );
  }

  // Button Section
  Widget _buildButtonSection(BuildContext context, ChangePasswordProvider provider) {
    return Container(
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      child: Column(
        children: [
          // Forgot Password Button
          SizedBox(
            width: double.infinity,
            child: CommonButton(
              type: ButtonType.secondary,
              label: context.lang.forgot_current_password,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const ForgotPasswordSendEmailScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: SizeConstant.spaceMedium),
          // Save Changes Button
          SizedBox(
            width: double.infinity,
            child: CommonButton(
              type: ButtonType.primary,
              label: context.lang.save_changes,
              isEnabled: provider.isButtonEnabled,
              onPressed: () {
                if (provider.validateForm()) {
                  // Handle password confirmation logic
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
