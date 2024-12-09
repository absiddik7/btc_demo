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
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_input_field.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/profile_avatar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/secondary_icon_button.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PersonalInfoProvider(),
      child: Scaffold(
        body: Consumer2<ThemeProvider, PersonalInfoProvider>(
          builder: (context, themeProvider, personalInfoProvider, child) {
            final textColor = themeProvider.currentTheme.textPrimaryColor;
            final iconColor = themeProvider.currentTheme.iconColor;
            final borderColor = themeProvider.currentTheme.borderColor;
            final backgroundColor = themeProvider.currentTheme.appSecondaryColor;

            return CustomBackground(
              child: Column(
                children: [
                  CustomAppBar(title: context.lang.profile_info),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Image
                            personalInfoProvider.selectedImage == null
                                ? _buildDefaultAvatar(backgroundColor, borderColor, iconColor)
                                : _buildProfileAvatar(personalInfoProvider.selectedImage!),

                            const SizedBox(height: SizeConstant.spaceLarge),

                            // Conditionally render upload or delete button
                            personalInfoProvider.selectedImage == null
                                ? _buildUploadButton(context, personalInfoProvider)
                                : _buildDeleteButton(context, personalInfoProvider),

                            const SizedBox(height: SizeConstant.spaceLarge),

                            // Pre-made avatars section
                            Text(context.lang.pre_made_avatars, style: AppTextStyles.outfitSB16(color: textColor)),
                            const SizedBox(height: SizeConstant.spaceMedium),
                            _buildAvatarSelectionList(context, themeProvider),

                            const SizedBox(height: SizeConstant.spaceLarge),

                            // Display Name
                            Text(context.lang.display_name, style: AppTextStyles.outfitSB16(color: textColor)),
                            const SizedBox(height: SizeConstant.spaceMedium),
                            _buildNameInputField(),

                            const SizedBox(height: SizeConstant.spaceLarge),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(SizeConstant.appHorizontalPadding),
          child: CommonButton(
            type: ButtonType.primary,
            label: context.lang.save_changes,
            onPressed: () {
              // Handle save functionality
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(Color backgroundColor, Color borderColor, Color iconColor) {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.imageFallbackIcon,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(File image) {
    return Center(
      child: CircleAvatar(
        radius: 75,
        backgroundImage: FileImage(image),
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context, PersonalInfoProvider personalInfoProvider) {
    return SecondaryIconButton(
      type: SecondaryIconButtonType.photoUploadButton,
      label: context.lang.upload_photo,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => _buildBottomSheet(context, personalInfoProvider),
        );
      },
    );
  }

  Widget _buildDeleteButton(BuildContext context, PersonalInfoProvider personalInfoProvider) {
    return SecondaryIconButton(
      type: SecondaryIconButtonType.deleteButton,
      label: context.lang.delete_photo,
      onPressed: personalInfoProvider.deleteImage,
    );
  }

  Widget _buildBottomSheet(BuildContext context, PersonalInfoProvider personalInfoProvider) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: Text(context.lang.gallery),
          onTap: () {
            Navigator.pop(context);
            personalInfoProvider.pickImage();
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: Text(context.lang.camera),
          onTap: () {
            Navigator.pop(context);
            personalInfoProvider.captureImage();
          },
        ),
      ],
    );
  }

  Widget _buildAvatarSelectionList(BuildContext context, ThemeProvider themeProvider) {
    return Consumer<PersonalInfoProvider>(
      builder: (context, personalInfoProvider, child) {
        return SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: personalInfoProvider.avatars.length,
            itemBuilder: (context, index) {
              final avatar = personalInfoProvider.avatars[index];
              return GestureDetector(
                onTap: () {
                  personalInfoProvider.selectAvatar(index);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConstant.paddingMedium),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: personalInfoProvider.selectedAvatarIndex == index
                            ? themeProvider.currentTheme.appThirdColor
                            : Colors.transparent,
                        width: SizeConstant.borderWidthLarge,
                      ),
                    ),
                    child: ProfileAvatar(
                      size: 78,
                      imagePath: avatar['icon']!,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNameInputField() {
    return Consumer<PersonalInfoProvider>(
      builder: (context, personalInfoProvider, child) {
        return Form(
          key: personalInfoProvider.formKey,
          child: CustomInputField(
            controller: personalInfoProvider.nameController,
            hintText: '',
          ),
        );
      },
    );
  }
}
