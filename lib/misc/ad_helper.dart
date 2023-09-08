import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7725118710955252/6959432733';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7725118710955252/6165225818';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7725118710955252/8080942712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7725118710955252/1675316461';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
