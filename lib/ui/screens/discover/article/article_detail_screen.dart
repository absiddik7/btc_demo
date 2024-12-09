import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/models/discover/news_model.dart';
import 'package:mybtccanvas/core/providers/discover/discover_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/image_error_fallback.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/news_chips_button.dart';
import 'package:provider/provider.dart';

class NewsArticleDetailScreen extends StatefulWidget {
  final ArticleModel articleModel;
  final bool isSaved;
  final String heroTag;
  const NewsArticleDetailScreen({super.key, required this.articleModel, required this.isSaved, required this.heroTag});

  @override
  State<NewsArticleDetailScreen> createState() => _NewsArticleDetailScreenState();
}

class _NewsArticleDetailScreenState extends State<NewsArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<ThemeProvider, DiscoverProvider>(
          builder: (context, themeProvider, discoverProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // custom app bar with container, back button and title
                CustomAppBar(
                  title: context.lang.news_details,
                  trailingIcon: SvgPicture.asset(
                    widget.isSaved? AppAssets.heartIconFill : AppAssets.heartIcon,
                    width: SizeConstant.iconSizeMedium,
                    height: SizeConstant.iconSizeMedium,
                    colorFilter: widget.isSaved? ColorFilter.mode(themeProvider.currentTheme.appRedColor, BlendMode.srcIn) 
                      : ColorFilter.mode(themeProvider.isDarkMode? themeProvider.currentTheme.appWhiteColor:themeProvider.currentTheme.appGreyColor , BlendMode.srcIn),
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConstant.appHorizontalPadding,
                        vertical: SizeConstant.appVerticalPadding),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 220,
                            decoration: BoxDecoration(
                              color: themeProvider.currentTheme.appSecondaryColor,
                              borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                              border: themeProvider.isDarkMode
                                  ? null
                                  : Border.all(
                                      color: themeProvider.currentTheme.borderColor,
                                      width: SizeConstant.borderWidthSmall),
                            ),
                            
                            child: Hero(
                              tag: widget.heroTag,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                                  child: Image.network(
                                    widget.articleModel.articleImage,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const ImageErrorFallback();
                                    },
                                    errorBuilder:
                                        (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return const ImageErrorFallback();
                                    },
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: SizeConstant.spaceLarge,
                          ),
                          Text(
                            widget.articleModel.articleTitle,
                            style:
                                AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: SizeConstant.spaceLarge,
                          ),
                          Text(
                            widget.articleModel.articleDescription,
                            style:
                                AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                          ),
                          const SizedBox(
                            height: SizeConstant.spaceLarge,
                          ),
                          Container(
                            height: SizeConstant.buttonHeightExtraSmall,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                              itemCount: widget.articleModel.articleChips.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                bool isOddIndex = index.isOdd;
                                return Padding(
                                  padding: const EdgeInsets.only(right: SizeConstant.paddingSmall),
                                  child: NewsChipsButton(
                                    themeProvider: themeProvider,
                                    title: widget.articleModel.articleChips[index],
                                    bgColor: isOddIndex
                                        ? themeProvider.currentTheme.appPrimaryColor
                                        : themeProvider.currentTheme.appThirdColor, // background color
                                    textColor: isOddIndex
                                        ? themeProvider.currentTheme.appDarkGreenColor
                                        : themeProvider.currentTheme.appThirdColor, // text Color
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: SizeConstant.spaceLarge,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        context.lang.created_by,
                                        style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                                      ),
                                      Text(
                                        widget.articleModel.createdBy,
                                        style: AppTextStyles.urbanistR14(
                                            color: themeProvider.isDarkMode
                                                ? themeProvider.currentTheme.appPrimaryColor
                                                : themeProvider.currentTheme.appThirdColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.heartIcon,
                                        width: SizeConstant.iconSizeMedium,
                                        height: SizeConstant.iconSizeMedium,
                                        colorFilter: ColorFilter.mode(
                                            themeProvider.isDarkMode
                                                ? themeProvider.currentTheme.appWhiteColor
                                                : themeProvider.currentTheme.appGreyColor,
                                            BlendMode.srcIn),
                                      ),
                                      const SizedBox(
                                        width: SizeConstant.spaceExtraSmall,
                                      ),
                                      Text(
                                        widget.articleModel.totalreaction.toString(),
                                        textAlign: TextAlign.end,
                                        style: AppTextStyles.outfitR16(
                                            color: themeProvider.currentTheme.textPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
