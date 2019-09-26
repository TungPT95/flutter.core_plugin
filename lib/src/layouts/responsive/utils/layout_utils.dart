import 'package:flutter/material.dart';

import '../constants.dart';

bool isMobileScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < TABLET_WIDTH_MIN;
}

bool isTabletScreen(BuildContext context) {
  return MediaQuery.of(context).size.width >= TABLET_WIDTH_MIN &&
      MediaQuery.of(context).size.width < DESKTOP_WIDTH_MIN;
}

bool isDesktopScreen(BuildContext context) {
  return MediaQuery.of(context).size.width >= DESKTOP_WIDTH_MIN;
}