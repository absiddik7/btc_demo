import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/password_input_field.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/providers/auth/confirm_password_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConfirmPasswordProvider(),
      child: Scaffold(
        body: Consumer2<ThemeProvider, ConfirmPasswordProvider>(
          builder: (context, themeProvider, confirmPasswordProvider, _) {
            return CustomBackground(
              child: Column(
                children: [
                  // App Bar
                  const CustomAppBar(title: ''),
                  // main content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            _buildTitleAndDescription(context, themeProvider),
                            const SizedBox(height: SizeConstant.spaceLarge),
                            // password input form
                            _buildPasswordInputForm(context, confirmPasswordProvider),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Button Section
                  _buildButtonSection(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Title and Description Section
  Widget _buildTitleAndDescription(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.lang.forgot_password,
          style: AppTextStyles.outfitSB40(color: themeProvider.currentTheme.textPrimaryColor),
        ),
        const SizedBox(height: SizeConstant.spaceSmall),
        Text(
          context.lang.new_password_description,
          style: AppTextStyles.outfitR16(color: themeProvider.currentTheme.textSecondaryColor),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  // Password Input Fields Form
  Widget _buildPasswordInputForm(BuildContext context, ConfirmPasswordProvider provider) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PasswordInputField(
            hintText: context.lang.password,
            validator: (value) => provider.passwordValidator(context, value),
            controller: passwordController,
          ),
          const SizedBox(height: SizeConstant.spaceLarge),
          PasswordInputField(
            hintText: context.lang.confirm_password,
            validator: (value) => provider.confirmPasswordValidator(context, value, passwordController.text),
            controller: confirmPasswordController,
          ),
        ],
      ),
    );
  }

  // Button Section
  Widget _buildButtonSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      child: CommonButton(
        type: ButtonType.primary,
        label: context.lang.confirm,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Handle confirmation logic
          }
        },
      ),
    );
  }
}
