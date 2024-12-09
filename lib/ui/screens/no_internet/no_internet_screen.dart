import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/connectivity/connectivity.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:provider/provider.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ThemeProvider, ConnectivityProvider>(
        builder: (context, themeProvider, connectivityProvider, _) {
          final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;

          return GestureDetector(
            onVerticalDragStart: (details) {
              {
                connectivityProvider.checkAndReload();
              }
            },
            child: CustomBackground(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        connectivityProvider.isLoading
                            ? const CupertinoActivityIndicator(
                                radius: 50,
                              )
                            : Image.asset(
                                AppAssets.noInternetImg,
                                height: 150,
                              ),
                        const SizedBox(height: 20),
                        Text(
                          "No internet connection",
                          style: AppTextStyles.outfitSB24(
                            color: primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Refresh the page by dragging your finger downward",
                          style: AppTextStyles.outfitR16(
                            color: primaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
