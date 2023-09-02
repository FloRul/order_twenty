import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/widgets/bottom_bar.dart';
import 'package:order_twenty/widgets/draggable_number.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/widgets/toggle_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order twenty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const GamePage(title: 'Order twenty'),
    );
  }
}

class GamePage extends ConsumerWidget {
  const GamePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameControllerNotifierProvider);
    return LayoutBuilder(
      builder: (_, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(title),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text('Number to order:'),
                  DraggableNumber(currentNumber: controller.currentNumber),
                ],
              ),
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TogglesGrid(),
                  ),
                ),
              ),
              const BottomBar(),
            ],
          ),
        );
      },
    );
  }
}
