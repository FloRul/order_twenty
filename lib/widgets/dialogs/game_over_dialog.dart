﻿import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:order_twenty/misc/ad_helper.dart';
import 'package:order_twenty/providers/game_controller.dart';

class GameOverDialog extends ConsumerStatefulWidget {
  const GameOverDialog({super.key, required this.onResetPressed});
  final VoidCallback onResetPressed;

  @override
  ConsumerState<GameOverDialog> createState() => _GameOverDialogState();
}

class _GameOverDialogState extends ConsumerState<GameOverDialog> {
  RewardedAd? _rewardedAd;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game'.toUpperCase(),
                style: const TextStyle(fontSize: 25),
              ),
              Text(
                ' over'.toUpperCase(),
                style: const TextStyle(fontSize: 25),
              ),
            ].animate(interval: 400.milliseconds).slideY(begin: -1, end: 0).fadeIn(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Score  '.toUpperCase()),
              Text(
                (ref.watch(gameControllerNotifierProvider).alreadyPickedNumbers.length - 1).toString(),
              ),
            ].animate(interval: 400.milliseconds).slideY(begin: 1, end: 0, delay: 800.milliseconds).fadeIn(),
          )
        ],
      ),
      actions: [
        // ElevatedButton(
        //   child: const Row(children: [
        //     Icon(Icons.ondemand_video),
        //     Text('Skip this number'),
        //   ]),
        //   onPressed: () {
        //     if (_rewardedAd != null) {
        //       _rewardedAd?.show(
        //         onUserEarnedReward: (ad, reward) {
        //           // TODO: skip number
        //         },
        //       );
        //     } else {
        //       widget.onResetPressed();
        //     }
        //   },
        // ),
        IconButton.filledTonal(
          icon: const Icon(Icons.refresh),
          onPressed: widget.onResetPressed,
        )
            .animate()
            .fadeIn(delay: 1400.milliseconds)
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shake(duration: 1.seconds, curve: Curves.bounceInOut, rotation: 90),
      ],
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }
}
