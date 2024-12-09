import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:mybtccanvas/core/models/discover/content_model.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/discover/discover_explore/content_dialog_box.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/image_error_fallback.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/play_button.dart';
import 'package:mybtccanvas/ui/widgets/video_player/customized_video_player.dart';
import 'package:provider/provider.dart';

class ContentStack extends StatefulWidget {
  final List<ContentModel> courseContentList;
  final double containerHeight;
  const ContentStack({super.key, required this.courseContentList, required this.containerHeight});

  @override
  State<ContentStack> createState() => _ContentStackState();
}

class _ContentStackState extends State<ContentStack> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Swiper(
          containerWidth: double.infinity,
          itemWidth: double.infinity,
          itemHeight: widget.containerHeight+20,
          loop: true,
          duration: 400,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final content = widget.courseContentList[index];
            return InkWell(
              onTap: () {
                if(content.type == ContentType.video) {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => 
                        CustomizedVideoPlayer(
                          url: content.url!,
                        )
                      )
                  );
                } else if(content.type == ContentType.text) {
                  showDialog(
                    barrierColor: themeProvider.currentTheme.appBlackColor.withOpacity(0.7),
                    context: context,
                    builder: (BuildContext context) {
                      return ContentDialogBox(
                        content: content,
                      );
                    },
                  );
                } else if(content.type == ContentType.button) {
                  // Handle button click
                } else if(content.type == ContentType.document) {
                  // Handle document click
                }
              },
              child: _buildSpecificContent(context, content, themeProvider)
            ); // Handle different content types
          },
          itemCount: widget.courseContentList.length,
          layout: SwiperLayout.TINDER,
        );
      },
    );
  }

  Widget _buildSpecificContent(BuildContext context, ContentModel content, ThemeProvider themeProvider) {
    switch (content.type) {
      case ContentType.video:
        return _buildVideoContent(content, themeProvider); 
      case ContentType.text:
        return _buildTextContent(content, themeProvider); 
      case ContentType.button:
        return _buildButtonContent(content, themeProvider); 
      case ContentType.document:
        return _buildDocumentContent(content, themeProvider);
      default:
        return const SizedBox();
    }
  }


  Widget _buildVideoContent(ContentModel content, ThemeProvider themeProvider) {
    // Replace with actual video player widget
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.currentTheme.videoCardBackgroundColor,
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium)
      ),
      height: widget.containerHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 52,
            width: 52,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: const PlayButton(
              iconSize: SizeConstant.iconSizeMedium - 1,
            ),
          ),

          const SizedBox(height: SizeConstant.spaceSmall),

          Text(
            content.title,
            style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(ContentModel content, ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      height: widget.containerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeProvider.currentTheme.imageFallbackGradientOneColor,
            themeProvider.currentTheme.imageFallbackGradientTwoColor,
          ],
        ),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
            child: Image.network(
              height: SizeConstant.iconSizeExtraLarge,
              width: SizeConstant.iconSizeExtraLarge,
              content.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                  height: SizeConstant.iconSizeExtraLarge,
                  width: SizeConstant.iconSizeExtraLarge,
                  alignment: Alignment.center,
                  child: const ImageErrorFallback()
                );
              },
                    
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Container(
                  height: SizeConstant.iconSizeExtraLarge,
                  width: SizeConstant.iconSizeExtraLarge,
                  alignment: Alignment.center,
                  child: const ImageErrorFallback()
                );
              },
            )
          ),
          const SizedBox(height: SizeConstant.spaceSmall,),

          Text(content.title, style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor)),

          const SizedBox(height: SizeConstant.spaceSmall,),

          Text(
            content.description, 
            style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

          const SizedBox(height: SizeConstant.spaceSmall,),

          Text(context.lang.read_more, style: AppTextStyles.urbanistB14(color: themeProvider.currentTheme.textPrimaryColor)),
        ],
      ),
    );
  }

  Widget _buildButtonContent(ContentModel content, ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        color: themeProvider.currentTheme.videoCardBackgroundColor,
      ),
      height: widget.containerHeight,
      width: double.infinity,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: SizeConstant.spaceLarge*2),
        child: CommonButton(
          type: ButtonType.primary,
          label: context.lang.getting_started,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildDocumentContent(ContentModel content, ThemeProvider themeProvider) {
    return Container(
      height: widget.containerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        color: themeProvider.currentTheme.videoCardBackgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.insert_drive_file, size: SizeConstant.iconSizeExtraLarge, color: themeProvider.currentTheme.textPrimaryColor), 
            const SizedBox(height: SizeConstant.spaceSmall),
            Text(
              "${context.lang.document} ${content.url}",
              style: const TextStyle(fontSize: SizeConstant.spaceMedium),
            ),
          ],
        ),
      ),
    );
  }



}