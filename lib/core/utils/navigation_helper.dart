import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  /// Determines if the platform should use Cupertino navigation
  static bool isCupertinoPlatform() {
    if (kIsWeb) return false; // Default to Material for Web
    return Platform.isIOS || Platform.isMacOS;
  }

  /// Navigate to a new page dynamically
  static void navigateTo(BuildContext context, Widget page) {
    if (isCupertinoPlatform()) {
      Navigator.of(context).push(CupertinoPageRoute(builder: (_) => page));
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
    }
  }

  /// Replace the current page dynamically
  static void navigateToReplacement(BuildContext context, Widget page) {
    if (isCupertinoPlatform()) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => page));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => page));
    }
  }

  /// Pop the current page
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}