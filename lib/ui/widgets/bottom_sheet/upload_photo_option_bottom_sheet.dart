import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/personal_info/personal_info_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class UploadPhotoOptionBottomSheet extends StatelessWidget {
  final PersonalInfoProvider personalInfoProvider;
  const UploadPhotoOptionBottomSheet({
    super.key,
    required this.personalInfoProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color backgroundColor = themeProvider.currentTheme.communityBoardItemColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        return Container(
          padding: const EdgeInsets.all(SizeConstant.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.lang.upload_photo,
                style: AppTextStyles.outfitSB24(color: textColor),
              ),
              const SizedBox(height: SizeConstant.spaceMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Gallery option
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        personalInfoProvider.pickImage();
                      },
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(color: borderColor, width: SizeConstant.borderWidthSmall),
                          borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_library, color: iconColor, size: SizeConstant.iconSizeMedium),
                            const SizedBox(height: SizeConstant.spaceSmall),
                            Text(
                              context.lang.gallery,
                              style: AppTextStyles.outfitR16(color: textColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: SizeConstant.spaceMedium),
                  // Camera option
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        personalInfoProvider.captureImage();
                      },
                      child: Container(
                        height: 91,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(color: borderColor, width: SizeConstant.borderWidthSmall),
                          borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: iconColor, size: SizeConstant.iconSizeMedium),
                            const SizedBox(height: SizeConstant.spaceSmall),
                            Text(
                              context.lang.camera,
                              style: AppTextStyles.outfitR16(color: textColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SizeConstant.spaceLarge),
            ],
          ),
        );
      },
    );
  }
}
