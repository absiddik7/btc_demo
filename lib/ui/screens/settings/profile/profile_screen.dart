import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/profile/profile_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/env.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/auth/change_password/change_password_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/appearance/appearance_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/currency/currency_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/language/language_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/personal_info/personal_info_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/preferred_exchange/preferred_exchange_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/profile/achievements_item.dart';
import 'package:mybtccanvas/ui/screens/settings/profile/profile_items.dart';
import 'package:mybtccanvas/ui/screens/settings/subscription/subscription_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/web_view/web_view_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/logout_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/parent_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/red_secondary_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/profile_avatar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, ProfileProvider>(
      builder: (context, themeProvider, profileProvider, child) {
        // Fetch theme colors from ThemeProvider
        final cardColor = themeProvider.currentTheme.appSecondaryColor;
        final textColor = themeProvider.currentTheme.textPrimaryColor;
        final sencondaryTextColor = themeProvider.currentTheme.textSecondaryColor;
        final borderColor = themeProvider.currentTheme.borderColor;

        return Scaffold(
          body: CustomBackground(
            child: Column(
              children: [
                CustomAppBar(
                  title: context.lang.profile,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: ProfileAvatar(
                                  size: 150,
                                  imagePath: AppAssets.profileImg,
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceExtraSmall),
                              Center(
                                child: Text(
                                  profileProvider.username,
                                  style: AppTextStyles.outfitSB40(color: textColor),
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceExtraSmall),
                              Center(
                                child: Text(
                                  profileProvider.joinDate,
                                  style: AppTextStyles.outfitR16(color: sencondaryTextColor),
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceLarge),
                            ],
                          ),
                        ),
                    
                        // Achievements Section
                        SizedBox(
                          height: 120, // Set a fixed height for the horizontal scroll area
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: profileProvider.achievements.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConstant.appHorizontalPadding, 
                                  right: index+1 == profileProvider.achievements.length? SizeConstant.appHorizontalPadding : 0
                                ),
                                child: AchievementsItem(
                                  icon: profileProvider.achievements[index]['icon'],
                                  title: profileProvider.achievements[index]['title'],
                                  subtitle: profileProvider.achievements[index]['subtitle'],
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: SizeConstant.spaceLarge),
                    
                        // General Settings
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: SizeConstant.paddingMedium),
                                child: Text(
                                  context.lang.general,
                                  style: AppTextStyles.urbanistR14(color: textColor),
                                ),
                              ),
                                                  
                              const SizedBox(height: SizeConstant.spaceMedium),
                                                  
                              Container(
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  border: Border.all(color: borderColor),
                                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                                ),
                                child: Column(
                                  children: [
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.personIcon,
                                      title: context.lang.personal_info,
                              
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) =>
                                              const PersonalInfoScreen())), // Navigate to Profile page
                                    ),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.subscriptionsIcon,
                                      title: context.lang.subscriptions,
                                      onTap: () => Navigator.of(context)
                                          .push(CupertinoPageRoute(builder: (context) => const SubscriptionScreen())),
                                    ),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.btcIcon,
                                      title: context.lang.preferred_exchange,
                              
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) =>
                                              const PreferredExchangeScreen())), // Navigate to Profile page
                                    ),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.myBitcoinIcon,
                                      title: context.lang.currency,
                              
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) =>
                                              const CurrencyScreen())), // Navigate to Profile page
                                    ),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.languageIcon,
                                      title: context.lang.language,
                              
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) =>
                                              const LanguageScreen())), // Navigate to Profile page
                                    ),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.appearanceIcon,
                                      title: context.lang.appearance,
                              
                                      showDivider: false,
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) =>
                                              const AppearanceScreen())), // Navigate to Profile page
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceLarge),
                                                  
                              // Account Details Settings
                              Padding(
                                padding: const EdgeInsets.only(left: SizeConstant.paddingMedium),
                                child: Text(
                                  context.lang.account_details,
                                  style: AppTextStyles.urbanistR14(color: textColor),
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceMedium),
                              Container(
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  border: Border.all(color: borderColor),
                                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                                ),
                                child: Column(
                                  children: [
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.lockIcon,
                                      title: context.lang.password,
                                      showDivider: false,
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) => const ChangePasswordScreen())),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceLarge),
                                                  
                              // Other settings
                              Padding(
                                padding: const EdgeInsets.only(left: SizeConstant.paddingMedium),
                                child: Text(
                                  context.lang.other,
                                  style: AppTextStyles.urbanistR14(color: textColor),
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceMedium),
                              Container(
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  border: Border.all(color: borderColor),
                                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                                ),
                                child: Column(
                                  children: [
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.feedbackIcon,
                                      title: context.lang.leave_feedback,
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) => WebViewScreen(
                                                title: context.lang.leave_feedback,
                                                webUrl: leaveFeedbackUrl,
                                              ))),
                                    ),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.rateUsIcon,
                                      title: context.lang.rate_us,
                                      onTap: () {},
                                    ),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.featureRequestIcon,
                                      title: context.lang.feature_request,
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) => WebViewScreen(
                                                title: context.lang.feature_request,
                                                webUrl: featureRequestUrl,
                                              ))),
                                    ),
                                    ProfileItem(
                                        leadingSVGIcon: AppAssets.contactSupportIcon,
                                        title: context.lang.contact_support,
                                        onTap: () async {
                                          String? encodeQueryParameters(Map<String, String> params) {
                                            return params.entries
                                                .map((MapEntry<String, String> e) =>
                                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                .join('&');
                                          }
                                                
                                          final Uri emailLaunchUri = Uri(
                                            scheme: 'mailto',
                                            path: 'support@bitcoincanvas.app',
                                            query: encodeQueryParameters(<String, String>{
                                              'subject': 'Support Request',
                                              'body': 'Describe your issue here...',
                                            }),
                                          );
                                          try {
                                            await launchUrl(emailLaunchUri);
                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Sending Message"),
                                            ));
                                          }
                                        }),
                                    ProfileItem(
                                      leadingSVGIcon: AppAssets.privacyPolicyIcon,
                                      title: context.lang.privacy_policy,
                                      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                          builder: (context) => WebViewScreen(
                                                title: context.lang.privacy_policy,
                                                webUrl: privacyPolicyUrl,
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: SizeConstant.spaceLarge),
                                                  
                              // Logout Button
                              RedSecondaryButton(
                                onPressed: () {
                                  ParentBottomSheet.show(context, child: const LogoutBottomSheet());
                                },
                                title: context.lang.log_out,
                              ),

                              const SizedBox(height: SizeConstant.spaceLarge),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
