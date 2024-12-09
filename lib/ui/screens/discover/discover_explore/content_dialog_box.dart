import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/image_error_fallback.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/models/discover/content_model.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/video_player/customized_video_player.dart';
import 'package:provider/provider.dart';

class ContentDialogBox extends StatefulWidget {
  final ContentModel content;
  const ContentDialogBox({super.key, required this.content});

  @override
  State<ContentDialogBox> createState() => _ContentDialogBoxState();
}

class _ContentDialogBoxState extends State<ContentDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: SizeConstant.paddingMedium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: double.infinity,
              padding: const EdgeInsets.all(SizeConstant.paddingMedium),
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
                      widget.content.imageUrl,
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
                  Text(widget.content.title, style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor)),

                  const SizedBox(height: SizeConstant.spaceSmall,),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Text(
                        widget.content.description, 
                        style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: SizeConstant.spaceMedium,),
                  CommonButton(
                    type: ButtonType.primary,
                    label: context.lang.watch_video,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => 
                          CustomizedVideoPlayer(
                            url: widget.content.url!,
                          )
                        )
                    );
                    },
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}