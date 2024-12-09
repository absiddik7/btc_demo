import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/models/discover/news_model.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/image_error_fallback.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/news_chips_button.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatefulWidget {
  final ArticleModel articleModel;
  final double height;
  final double width;
  final bool isSaved;
  final String heroTag;
  const ArticleCard({super.key, required this.articleModel, required this.height, required this.width, required this.isSaved, required this.heroTag});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: themeProvider.currentTheme.appSecondaryColor,
            borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
            border: Border.all(color: themeProvider.currentTheme.borderColor, width: SizeConstant.borderWidthSmall),
          ),
          padding: const EdgeInsets.all(SizeConstant.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: themeProvider.currentTheme.appSecondaryColor,
                    borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                    border: themeProvider.isDarkMode? null : Border.all(color: themeProvider.currentTheme.borderColor, width: SizeConstant.borderWidthSmall),
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
                      
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const ImageErrorFallback();
                        },
                      )
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SizeConstant.spaceMedium,),

              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.articleModel.articleTitle,
                        style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      Text(
                        widget.articleModel.articleSubtitle,
                        style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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
                                bgColor: isOddIndex? themeProvider.currentTheme.appPrimaryColor: themeProvider.currentTheme.appThirdColor,  // background color
                                textColor: isOddIndex? themeProvider.currentTheme.appDarkGreenColor: themeProvider.currentTheme.appThirdColor,  // text Color
                              ),
                            );
                          },
                        ),
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
                                    style: AppTextStyles.urbanistR14(color: themeProvider.isDarkMode? themeProvider.currentTheme.appPrimaryColor : themeProvider.currentTheme.appThirdColor),
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
                                    widget.isSaved? AppAssets.heartIconFill : AppAssets.heartIcon,
                                    width: SizeConstant.iconSizeMedium,
                                    height: SizeConstant.iconSizeMedium,
                                    colorFilter: widget.isSaved? ColorFilter.mode(themeProvider.currentTheme.appRedColor, BlendMode.srcIn) 
                                      : ColorFilter.mode(themeProvider.isDarkMode? themeProvider.currentTheme.appWhiteColor:themeProvider.currentTheme.appGreyColor , BlendMode.srcIn),
                                  ),
                                  const SizedBox(width: SizeConstant.spaceSmall,),
                                  Text(
                                    widget.articleModel.totalreaction.toString(),
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.outfitR16(color: themeProvider.currentTheme.textPrimaryColor),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        );
      },
    );
  }
}