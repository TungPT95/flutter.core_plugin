import 'dart:io';

import 'package:url_launcher/url_launcher.dart' as url_launcher;

bool isMobileOS() {
  return Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
}

bool isDesktopOS() {
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

mobileLaunchUrl(url) async {
  try {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print(e.toString());
  }
}