import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/auth/forgot_password.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/auth/check_email/check_email_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_input_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordSendEmailScreen extends StatefulWidget {
  const ForgotPasswordSendEmailScreen({super.key});

  @override
  State<ForgotPasswordSendEmailScreen> createState() => _ForgotPasswordSendEmailScreenState();
}

class _ForgotPasswordSendEmailScreenState extends State<ForgotPasswordSendEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ThemeProvider, ForgotPasswordProvider>(
        builder: (context, themeProvider, forgotPasswordProvider, _) {
          final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;
          final Color secondaryTextColor = themeProvider.currentTheme.textSecondaryColor;

          return CustomBackground(
            child: Column(
              children: [
                // app bar
                const CustomAppBar(title: ''),
                // main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // title and description
                          _buildTitle(primaryTextColor),
                          _buildDescription(secondaryTextColor),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // email form
                          _buildEmailForm(forgotPasswordProvider),
                          const SizedBox(height: SizeConstant.spaceLarge),
                        ],
                      ),
                    ),
                  ),
                ),
                // send button
                _buildSendButton(context, forgotPasswordProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  // title section
  Widget _buildTitle(Color primaryTextColor) {
    return Text(
      context.lang.forgot_password,
      style: AppTextStyles.outfitSB40(color: primaryTextColor),
    );
  }

  // description section
  Widget _buildDescription(Color secondaryTextColor) {
    return Text(
      context.lang.forgot_password_description,
      style: AppTextStyles.outfitR16(color: secondaryTextColor),
      textAlign: TextAlign.start,
    );
  }

  // email form
  Widget _buildEmailForm(ForgotPasswordProvider forgotPasswordProvider) {
    return Form(
      key: _formKey,
      child: CustomInputField(
        hintText: context.lang.email,
        validator: (value) => forgotPasswordProvider.emailValidator(context, value),
        controller: emailController,
        prefixIcon: AppAssets.emailIcon,
      ),
    );
  }

  // send button
  Widget _buildSendButton(BuildContext context, ForgotPasswordProvider forgotPasswordProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      child: CommonButton(
        type: ButtonType.primary,
        label: context.lang.send,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            forgotPasswordProvider.sendResetPasswordEmail(context, emailController.text);
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const CheckEmailScreen()),
            );
          }
        },
      ),
    );
  }
}
