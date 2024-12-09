import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class AddWidgetMenuOptioinBottomSheet extends StatelessWidget {
  const AddWidgetMenuOptioinBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> boardList = [
      "Finance",
      "WHo owns SATS",
      "Network Pulse",
      "Miner's Haven"
    ];

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final backgroundColor =
            themeProvider.currentTheme.communityBoardItemColor;
        final borderColor = themeProvider.currentTheme.borderColor;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add widgrt',
                  style: AppTextStyles.outfitSB24(color: textColor)),
              const SizedBox(height: 16),
              // Dynamic List of CustomRadioButton
              ListView.builder(
                shrinkWrap: true,
                itemCount: boardList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      height: 54,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(
                          color: borderColor,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              boardList[index],
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                          ),
                          SvgPicture.asset(
                            AppAssets.arrowRightIcon,
                            colorFilter: ColorFilter.mode(
                              textColor,
                              BlendMode.srcIn,
                            ),
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
