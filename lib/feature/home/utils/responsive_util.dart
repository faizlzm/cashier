import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isMobileLandscape(BuildContext context) {
    return isMobile(context) && isLandscape(context);
  }

  static int getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLandscapeMode = isLandscape(context);

    if (width < 600) {
      return isLandscapeMode ? 3 : 2; // Mobile: 3 kolom landscape, 2 portrait
    } else if (width < 900) {
      return isLandscapeMode ? 4 : 3; // Small tablet
    } else if (width < 1200) {
      return 4; // Large tablet: 4 kolom
    } else if (width < 1600) {
      return 5; // Small desktop: 5 kolom
    } else {
      return 6; // Large desktop: 6 kolom
    }
  }

  static double getCartWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return width; // Mobile: full width (akan ditampilkan sebagai bottom sheet)
    } else if (width < 1024) {
      return 320; // Tablet: 320px
    } else {
      return 380; // Desktop: 380px
    }
  }
}