import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/auth/verify_email_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/core/utils/navigation_helper.dart';
import 'package:mybtccanvas/ui/screens/auth/otp_screen/otp_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;
            return ChangeNotifierProvider(
              create: (_) => VerifyEmailProvider(),
              child: Consumer<VerifyEmailProvider>(
                builder: (context, verifyEmailProvider, _) {
                  return Column(
                    children: [
                      // app bar
                      const CustomAppBar(title: ''),
                      // main content
                      Expanded(child: _buildContent(context, primaryTextColor)),
                      // bottom buttons
                      _buildBottomButtons(context, verifyEmailProvider),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // main content
  Widget _buildContent(BuildContext context, Color primaryTextColor) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(SizeConstant.paddingMedium),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.verifyEmailImg, height: 104),
              const SizedBox(height: SizeConstant.spaceLarge),
              Text(
                context.lang.check_email,
                style: AppTextStyles.outfitSB40(color: primaryTextColor),
              ),
              Text(
                context.lang.check_email_description,
                style: AppTextStyles.outfitR16(color: primaryTextColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // bottom buttons
  Widget _buildBottomButtons(BuildContext context, VerifyEmailProvider verifyEmailProvider) {
    return Padding(
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      child: Column(
        children: [
          // enter code button
          _buildEnterCodeButton(context),
          const SizedBox(height: SizeConstant.spaceMedium),
          // resend email button
          _buildResendEmailButton(context, verifyEmailProvider),
        ],
      ),
    );
  }

  // enter code button
  Widget _buildEnterCodeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CommonButton(
        type: ButtonType.primary,
        label: context.lang.enter_code,
        onPressed: () {
          NavigationHelper.navigateTo(context, const OtpScreen());
        },
      ),
    );
  }

  // resend email button
  Widget _buildResendEmailButton(BuildContext context, VerifyEmailProvider verifyEmailProvider) {
    return SizedBox(
      width: double.infinity,
      child: CommonButton(
        type: ButtonType.secondary,
        label: verifyEmailProvider.isButtonDisabled
            ? '${context.lang.resend_email} 0:${verifyEmailProvider.start.toString().padLeft(2, '0')}'
            : context.lang.didnt_get_code,
        onPressed: verifyEmailProvider.isButtonDisabled
            ? null
            : () {
                verifyEmailProvider.startTimer();
                // Add action for resending code here
              },
      ),
    );
  }
}
