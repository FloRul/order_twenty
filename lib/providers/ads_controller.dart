import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ads_controller.g.dart';

@riverpod
Future<void> adInitialization(AdInitializationRef ref) {
  return MobileAds.instance.initialize();
}
