import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/theme_controller.dart';
import 'package:order_twenty/widgets/game_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = ref.watch(themeControllerProvider);
    return MaterialApp(
      title: 'Order twenty',
      theme: theme.$1,
      darkTheme: theme.$2,
      home: const GamePage(title: 'Order twenty'),
    );
  }
}

class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(title),
          ),
          body: const GameView(),
        );
      },
    );
  }
}
