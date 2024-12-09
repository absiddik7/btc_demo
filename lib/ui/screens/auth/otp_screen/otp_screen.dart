import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/auth/otp_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/core/utils/navigation_helper.dart';
import 'package:mybtccanvas/ui/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pinputController = TextEditingController();

  @override
  void dispose() {
    pinputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ThemeProvider, OtpProvider>(
        builder: (context, themeProvider, otpProvider, _) {
          final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
          final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;
          final Color errorColor = themeProvider.currentTheme.errorColor;
          final Color focusBorderColor = themeProvider.currentTheme.appThirdColor;
          final Color defaultBorderColor = themeProvider.currentTheme.borderColor;

          return CustomBackground(
            child: Column(
              children: [
                // app bar
                const CustomAppBar(title: ''),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                    child: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            Text(
                              context.lang.enter_code,
                              style: AppTextStyles.outfitSB40(color: primaryTextColor),
                            ),
                            const SizedBox(height: SizeConstant.spaceSmall),
                            // description
                            Text(
                              context.lang.enter_code_description,
                              style: AppTextStyles.outfitR16(color: primaryTextColor),
                            ),
                            const SizedBox(height: SizeConstant.spaceLarge),

                            // Pinput OTP fields
                            buildOtpField(otpProvider, backgroundColor, primaryTextColor, errorColor,
                                defaultBorderColor, focusBorderColor),

                            // Display error message only if the input length is 4 and hasError is true
                            if (otpProvider.hasError && pinputController.text.length == 4)
                              Text(
                                'Please enter all fields',
                                style: TextStyle(color: errorColor),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Confirm Button
                confirmButton(context, otpProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  // Pinput OTP fields
  Widget buildOtpField(OtpProvider otpProvider, Color backgroundColor, Color primaryTextColor,
      Color errorColor, Color defaultBorderColor, Color focusBorderColor) {
    return Pinput(
      length: 4,
      controller: pinputController,
      focusNode: otpProvider.pinputFocusNode,
      onChanged: (value) {
        // Clear error state while the user is typing
        otpProvider.setHasError(false);
      },
      validator: (value) {
        return otpProvider.hasError ? 'Please enter all fields' : null;
      },
      defaultPinTheme: buildPinTheme(backgroundColor, primaryTextColor, defaultBorderColor),
      focusedPinTheme: buildPinTheme(backgroundColor, primaryTextColor, focusBorderColor),
      errorPinTheme: buildPinTheme(backgroundColor, primaryTextColor, errorColor),
    );
  }

  // pin theme
  PinTheme buildPinTheme(Color backgroundColor, Color primaryTextColor, Color borderColor) {
    return PinTheme(
      width: 84,
      height: 56,
      textStyle: AppTextStyles.outfitSB24(color: primaryTextColor),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        border: Border.all(color: borderColor),
      ),
    );
  }

  // Confirm Button
  Widget confirmButton(BuildContext context, OtpProvider otpProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      child: CommonButton(
        type: ButtonType.primary,
        label: context.lang.confirm,
        isEnabled: pinputController.text.length == 4,
        onPressed: () {
          otpProvider.validateOtp(pinputController.text);
          if (!otpProvider.hasError) {
            NavigationHelper.navigateTo(context, const BottomBarScreen());
          } else {
            pinputController.clear();
            otpProvider.setHasError(false);
          }
        },
      ),
    );
  }
}
