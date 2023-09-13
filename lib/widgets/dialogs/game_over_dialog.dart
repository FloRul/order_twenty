import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:order_twenty/misc/ad_helper.dart';

class GameOverDialog extends StatefulWidget {
  const GameOverDialog({super.key, required this.onResetPressed});
  final VoidCallback onResetPressed;

  @override
  State<GameOverDialog> createState() => _GameOverDialogState();
}

class _GameOverDialogState extends State<GameOverDialog> {
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
      content: const Text(
        'Game over',
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          child: const Row(children: [
            Icon(Icons.ondemand_video),
            Text('Skip this number'),
          ]),
          onPressed: () {
            if (_rewardedAd != null) {
              _rewardedAd?.show(
                onUserEarnedReward: (ad, reward) {
                  // TODO: skip number
                },
              );
            } else {
              widget.onResetPressed();
            }
          },
        ),
        IconButton.filledTonal(
          icon: const Icon(Icons.refresh),
          onPressed: widget.onResetPressed,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }
}
