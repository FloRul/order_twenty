import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:order_twenty/misc/ad_helper.dart';
import 'package:order_twenty/widgets/game_view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: MaterialApp(
        title: 'Order twenty',
        theme: FlexThemeData.light(
          scheme: FlexScheme.deepOrangeM3,
        ).copyWith(textTheme: GoogleFonts.playTextTheme()),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepOrangeM3).copyWith(
          textTheme: GoogleFonts.playTextTheme(),
        ),
        themeMode: ThemeMode.dark,
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  BannerAd? _bannerAd;
  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          if (_bannerAd != null)
            SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          const Expanded(child: GameView()),
        ],
      )
          .animate(
            autoPlay: true,
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .custom(
            curve: Curves.linear,
            duration: 25.seconds,
            builder: (context, value, child) => Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withAlpha(125),
                    blurRadius: 45,
                    spreadRadius: 15,
                    offset: const Offset(0, 0),
                  )
                ],
                gradient: LinearGradient(
                  colors: [
                    scheme.primary,
                    scheme.secondary,
                  ],
                  begin: Alignment(-1, value * 2 - 1),
                  end: Alignment(1, -value * 2 + 1),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: child,
            ),
          ),
    );
  }
}
