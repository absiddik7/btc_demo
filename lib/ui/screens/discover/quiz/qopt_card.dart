import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/image_error_fallback.dart';
import 'package:provider/provider.dart';

class QandOptCard extends StatefulWidget {
  final String title;
  final String? imageUrl;
  final bool isQuestion;
  final bool? isSelected;
  const QandOptCard({super.key, this.imageUrl, required this.title, required this.isQuestion, this.isSelected});

  @override
  State<QandOptCard> createState() => _QandOptCardState();
}

class _QandOptCardState extends State<QandOptCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          decoration: BoxDecoration(
            color: themeProvider.currentTheme.appSecondaryColor,
            borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
            border: Border.all(
              color: widget.isSelected!=null && widget.isSelected!? themeProvider.currentTheme.textSecondaryColor : themeProvider.currentTheme.borderColor, 
              width: widget.isSelected!=null && widget.isSelected!? 1 : 0.5
            )
          ),
          padding: const EdgeInsets.all(SizeConstant.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.imageUrl != null? Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: themeProvider.currentTheme.appSecondaryColor,
                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                  border: themeProvider.isDarkMode? null : Border.all(color: themeProvider.currentTheme.textSecondaryColor.withOpacity(0.2), width: 1),
                ),
                padding: const EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                  child: Image.network(
                    widget.imageUrl!, 
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
              ) : Container(),

              SizedBox(height: widget.imageUrl != null? SizeConstant.spaceSmall : 0,),

              widget.isQuestion? Text(
                widget.title,
                style: AppTextStyles.outfitSB24(color: themeProvider.currentTheme.textPrimaryColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ) : Text(
                widget.title,
                style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}