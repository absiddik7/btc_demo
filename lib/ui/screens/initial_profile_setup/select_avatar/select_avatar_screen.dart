import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/personal_info/personal_info_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/parent_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/upload_photo_option_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/secondary_icon_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/profile_avatar.dart';
import 'package:provider/provider.dart';

class SelectAvatarScreen extends StatelessWidget {
  const SelectAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer2<ThemeProvider, PersonalInfoProvider>(
        builder: (context, themeProvider, personalInfoProvider, child) {
          final textColor = themeProvider.currentTheme.textPrimaryColor;
          final greyColor = themeProvider.currentTheme.appDarkGreyColor;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.lang.selecct_avatar,
                          style: AppTextStyles.outfitSB40(color: textColor),
                        ),
                        const SizedBox(height: SizeConstant.spaceSmall),
                        Text(
                          context.lang.selecct_avatar_description,
                          style: AppTextStyles.outfitR16(color: greyColor),
                        ),
                        const SizedBox(height: SizeConstant.spaceMedium),

                        // Pre-made avatars section
                        Text(context.lang.pre_made_avatars,
                            style: AppTextStyles.outfitSB16(color: textColor)),
                        const SizedBox(height: SizeConstant.spaceMedium),
                        // Display the list of avatars
                        _buildAvatarSelectionList(context, personalInfoProvider, themeProvider),
                        const SizedBox(height: SizeConstant.spaceMedium),
                        // Profile Image or Default Avatar
                        personalInfoProvider.selectedImage != null
                            ? _buildProfileAvatar(personalInfoProvider, themeProvider)
                            : Container(),
                        Center(
                          child: Text(context.lang.upload_own_photo,
                              style: AppTextStyles.outfitSB16(color: textColor)),
                        ),
                        //render upload button
                        _buildUploadButton(context, personalInfoProvider)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget to display the list of pre-made avatars
  Widget _buildAvatarSelectionList(
      BuildContext context, PersonalInfoProvider personalInfoProvider, ThemeProvider themeProvider) {
    final Color backgroundColor = themeProvider.currentTheme.appGreyColor;
    final Color borderColor = themeProvider.currentTheme.appThirdColor;
    const double avatarSize = 150;

    return SizedBox(
      height: 350,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 8, crossAxisCount: 2),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: personalInfoProvider.avatars.length,
        itemBuilder: (context, index) {
          final avatar = personalInfoProvider.avatars[index];

          return GestureDetector(
            onTap: () {
              personalInfoProvider.selectAvatar(index);
              personalInfoProvider.deleteImage(); // Clear the uploaded photo when an avatar is selected
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: SizeConstant.paddingMedium),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: personalInfoProvider.selectedAvatarIndex == index &&
                                personalInfoProvider.selectedImage == null
                            ? borderColor
                            : Colors.transparent,
                        width: 4,
                      ),
                    ),
                    child: ProfileAvatar(
                      size: avatarSize,
                      backgroundColor: backgroundColor,
                      imagePath: avatar['icon']!,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget to display the uploaded profile image
  Widget _buildProfileAvatar(PersonalInfoProvider personalInfoProvider, ThemeProvider themeProviser) {
    final Color iconColor = themeProviser.currentTheme.appWhiteColor;
    final Color borderColor = themeProviser.currentTheme.appThirdColor;
    final File image = personalInfoProvider.selectedImage!;

    return Container(
      margin: const EdgeInsets.only(bottom: SizeConstant.marginMedium),
      child: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: 4,
                ),
              ),
              child: CircleAvatar(
                radius: 75,
                backgroundImage: FileImage(image),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  personalInfoProvider.deleteImage();
                },
                child: Container(
                  width: 56,
                  height: 48,
                  decoration: const BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color(0xFF1D1C3D),
                  ),
                  padding: const EdgeInsets.all(SizeConstant.paddingSmall),
                  child: SvgPicture.asset(
                    width: 24,
                    height: 24,
                    AppAssets.deleteIcon,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display the upload button
  Widget _buildUploadButton(BuildContext context, PersonalInfoProvider personalInfoProvider) {
    return Container(
      margin: const EdgeInsets.only(top: SizeConstant.marginMedium, bottom: SizeConstant.marginLarge),
      child: SecondaryIconButton(
        type: SecondaryIconButtonType.photoUploadButton,
        label: context.lang.upload_photo,
        onPressed: () {
          ParentBottomSheet.show(
            context,
            child: UploadPhotoOptionBottomSheet(personalInfoProvider: personalInfoProvider),
          );
        },
      ),
    );
  }

}
