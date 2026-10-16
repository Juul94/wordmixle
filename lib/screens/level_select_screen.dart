import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_variant.dart';
import '../providers/progress_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/localization.dart';
import 'game_screen.dart';

class LevelSelectScreen extends ConsumerWidget {
  final GameVariant variant;

  const LevelSelectScreen({super.key, required this.variant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(settingsProvider).locale;
    final progress = ref.watch(progressProvider((variant: variant, locale: locale)));

    return Scaffold(
      appBar: AppBar(
        title: Text('${variant.label(locale)} - ${tr('levels', locale)}'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 100,
        itemBuilder: (context, index) {
          final level = index + 1;
          final unlocked = progress.isUnlocked(level);
          final completed = level <= progress.highestLevel;
          final diff = difficultyForLevel(level);

          Color bgColor;
          if (completed) {
            bgColor = Colors.green.withValues(alpha: 0.3);
          } else if (unlocked) {
            bgColor = Theme.of(context).colorScheme.primaryContainer;
          } else {
            bgColor = Theme.of(context).colorScheme.surfaceContainerHighest;
          }

          return Material(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: unlocked
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GameScreen(
                            variant: variant,
                            level: level,
                          ),
                        ),
                      )
                  : null,
              child: Center(
                child: unlocked
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$level',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: completed ? Colors.green : null,
                            ),
                          ),
                          Text(
                            _diffLabel(diff, locale),
                            style: const TextStyle(fontSize: 8),
                          ),
                        ],
                      )
                    : const Icon(Icons.lock, size: 16),
              ),
            ),
          );
        },
      ),
    );
  }

  String _diffLabel(Difficulty diff, String locale) {
    switch (diff) {
      case Difficulty.easy:
        return tr('easy', locale);
      case Difficulty.medium:
        return tr('medium', locale);
      case Difficulty.hard:
        return tr('hard', locale);
    }
  }
}
