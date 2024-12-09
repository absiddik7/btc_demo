import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mybtccanvas/core/providers/auth/change_password_provider.dart';
import 'package:mybtccanvas/core/providers/auth/confirm_password_provider.dart';
import 'package:mybtccanvas/core/providers/auth/forgot_password.dart';
import 'package:mybtccanvas/core/providers/auth/otp_provider.dart';
import 'package:mybtccanvas/core/providers/auth/signin_provider.dart';
import 'package:mybtccanvas/core/providers/auth/signup_provider.dart';
import 'package:mybtccanvas/core/providers/auth/verify_email_provider.dart';
import 'package:mybtccanvas/core/providers/bottom_bar/bottom_bar_provider.dart';
import 'package:mybtccanvas/core/providers/connectivity/connectivity.dart';
import 'package:mybtccanvas/core/providers/currency/currency_provider.dart';
import 'package:mybtccanvas/core/providers/discover/discover_provider.dart';
import 'package:mybtccanvas/core/providers/discover/video_player_provider.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/plan_providerd.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/profile_setup_flow_provider.dart';
import 'package:mybtccanvas/core/providers/language/language_provider.dart';
import 'package:mybtccanvas/core/providers/personal_info/personal_info_provider.dart';
import 'package:mybtccanvas/core/providers/preferred_exchange/preferred_exchange_prodiver.dart';
import 'package:mybtccanvas/core/providers/profile/profile_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/ui/screens/no_internet/no_internet_screen.dart';
import 'package:mybtccanvas/ui/screens/splash_screen/splash_screen.dart';
import 'package:mybtccanvas/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ChangeNotifierProvider(create: (context) => BottomBarProvider()),
      ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
      ChangeNotifierProvider(create: (context) => VerifyEmailProvider()),
      ChangeNotifierProvider(create: (context) => OtpProvider()),
      ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
      ChangeNotifierProvider(create: (context) => ConfirmPasswordProvider()),
      ChangeNotifierProvider(create: (context) => DiscoverProvider()),
      ChangeNotifierProvider(create: (context) => VideoPlayerProvider()),
      ChangeNotifierProvider(create: (context) => ChangePasswordProvider()),
      ChangeNotifierProvider(create: (context) => PersonalInfoProvider()),
      ChangeNotifierProvider(create: (context) => PreferredExchangeProvider()),
      ChangeNotifierProvider(create: (context) => CurrencyProvider()),
      ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ChangeNotifierProvider(create: (context) => SignupProvider()),
      ChangeNotifierProvider(create: (context) => SignInProvider()),
      ChangeNotifierProvider(create: (context) => ProfileSetupFlowProvider()),
      ChangeNotifierProvider(create: (context) => PlanProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.checkSystemTheme();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            // Update the system UI overlay based on the current theme
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!themeProvider.isDarkMode) {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.transparent,
                ));
              } else if (themeProvider.isDarkMode) {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.transparent,
                ));
              } else {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ));
              }
            });
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: context.watch<LanguageProvider>().appLocale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
                Locale('it'),
                Locale('es'),
              ],
              theme: ThemeData(
                primaryColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                scaffoldBackgroundColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                drawerTheme: DrawerThemeData(
                  backgroundColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                ),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                ),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                primaryColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                scaffoldBackgroundColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                drawerTheme: DrawerThemeData(
                  backgroundColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                ),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: themeProvider.currentTheme.mainBackgroundPrimaryColor,
                ),
                useMaterial3: true,
              ),
              themeMode: themeProvider.useSystemTheme
                  ? ThemeMode.system
                  : (themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light),
              builder: (context, child) {
                return Stack(
                  children: [
                    child!, // The current page
                    // Show NoInternetScreen overlay when offline
                    if (!connectivityProvider.isOnline) const NoInternetScreen(),
                  ],
                );
              },
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
