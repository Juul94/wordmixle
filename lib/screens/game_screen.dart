import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_variant.dart';
import '../models/letter_status.dart';
import '../providers/game_provider.dart';
import '../providers/progress_provider.dart';
import '../providers/settings_provider.dart';
import '../data/puzzle_data.dart';
import '../utils/localization.dart';

class GameScreen extends ConsumerWidget {
  final GameVariant variant;
  final int level;

  const GameScreen({super.key, required this.variant, required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(settingsProvider).locale;
    final key = (variant: variant, level: level, locale: locale);
    final game = ref.watch(gameStateProvider(key));
    final notifier = ref.read(gameStateProvider(key).notifier);
    final clue = getClue(variant, level, locale: locale);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${variant.label(locale)} - ${tr('level', locale)} $level',
        ),
        actions: [
          if (!game.isGameOver)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: game.hintsRemaining > 0
                    ? () => notifier.useHint()
                    : null,
                icon: Badge(
                  label: Text('${game.hintsRemaining}'),
                  backgroundColor: game.hintsRemaining > 0
                      ? Colors.amber
                      : Colors.grey,
                  child: Icon(
                    Icons.lightbulb_outline,
                    color: game.hintsRemaining > 0
                        ? Colors.amber
                        : Colors.grey,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (clue != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    clue,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          Expanded(child: _buildGrid(context, game, notifier)),
          if (game.isGameOver)
            _buildGameOverBanner(context, ref, game, locale)
          else
            _buildKeyboard(context, game, notifier, locale),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, dynamic game, dynamic notifier) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxBoxWidth = ((screenWidth - 48) / game.wordLength - 4).clamp(24.0, 48.0);
    final fontSize = maxBoxWidth > 36 ? 20.0 : 14.0;
    final confirmed = game.confirmedLetters as List<String>;

    final rows = List.generate(game.maxGuesses, (row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(game.wordLength, (col) {
                String letter = '';
                Color bg = Colors.transparent;
                Color border = Theme.of(context).colorScheme.outline;
                bool isSelected = false;

                if (row < game.guesses.length) {
                  final guess = game.guesses[row] as String;
                  if (col < guess.length) letter = guess[col].toUpperCase();
                  final feedback = game.feedbackFor(guess);
                  if (col < feedback.length) {
                    bg = _statusColor(feedback[col]);
                    border = bg;
                  }
                } else if (row == game.guesses.length) {
                  final cells = game.displayCells as List<String>;
                  if (cells[col].isNotEmpty) {
                    letter = cells[col].toUpperCase();
                    if ((game.revealedIndices as Set<int>).contains(col)) {
                      bg = Colors.green.withValues(alpha: 0.3);
                      border = Colors.green;
                    }
                  }
                  // Highlight selected cell
                  if (!game.isGameOver &&
                      col == game.selectedIndex &&
                      !(game.revealedIndices as Set<int>).contains(col)) {
                    isSelected = true;
                    border = Theme.of(context).colorScheme.primary;
                  }
                } else if ((game.revealedIndices as Set<int>).contains(col)) {
                  letter = (game.answer as String)[col].toUpperCase();
                  bg = Colors.green.withValues(alpha: 0.3);
                  border = Colors.green;
                }

                final isCurrentRow = row == game.guesses.length && !game.isGameOver;
                final canTap = isCurrentRow &&
                    !(game.revealedIndices as Set<int>).contains(col);

                return GestureDetector(
                  onTap: canTap ? () => notifier.selectIndex(col) : null,
                  child: Container(
                    width: maxBoxWidth,
                    height: maxBoxWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: bg,
                      border: Border.all(
                        color: border,
                        width: isSelected ? 2.5 : 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: bg != Colors.transparent ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (variant == GameVariant.classicWordle) ...[
            // Wrong-position letters shown above underscores
            Builder(builder: (_) {
              final statuses = game.keyboardStatuses as Map<String, LetterStatus>;
              final wrongPos = statuses.entries
                  .where((e) => e.value == LetterStatus.wrongPosition)
                  .map((e) => e.key.toUpperCase())
                  .toList();
              if (wrongPos.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Wrap(
                  spacing: 8,
                  children: wrongPos.map((l) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      l,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )).toList(),
                ),
              );
            }),
            // Underscores with confirmed letters
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(game.wordLength, (i) {
                  final c = confirmed[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      c.isNotEmpty ? c.toUpperCase() : '_',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: c.isNotEmpty
                            ? Colors.green
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
          ...rows,
        ],
      ),
    );
  }

  Widget _buildGameOverBanner(
    BuildContext context,
    WidgetRef ref,
    dynamic game,
    String locale,
  ) {
    if (game.isWon) {
      // Save progress
      Future.microtask(() {
        ref.read(progressProvider((variant: variant, locale: locale)).notifier).completeLevel(level);
      });
    }

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            game.isWon ? tr('you_won', locale) : tr('try_again_msg', locale),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (game.isWon) ...[
            const SizedBox(height: 8),
            Text(
              '${game.guesses.length}/${game.maxGuesses} ${tr('attempts', locale)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (game.isLost)
                FilledButton.tonal(
                  onPressed: () {
                    ref.read(gameStateProvider((variant: variant, level: level, locale: locale)).notifier).retry();
                  },
                  child: Text(tr('retry', locale)),
                ),
              if (game.isWon && level < 100) ...[
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameScreen(
                          variant: variant,
                          level: level + 1,
                        ),
                      ),
                    );
                  },
                  child: Text(tr('next_level', locale)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboard(BuildContext context, dynamic game, dynamic notifier, String locale) {
    final chars = getAllowedChars(variant, locale: locale);
    final keyboardStatuses = game.keyboardStatuses as Map<String, LetterStatus>;

    if (variant == GameVariant.numberle) {
      return _buildNumericKeyboard(context, chars, keyboardStatuses, notifier);
    }

    final rows = locale == 'da'
        ? ['qwertyuiopå', 'asdfghjklæø', 'zxcvbnm']
        : ['qwertyuiop', 'asdfghjkl', 'zxcvbnm'];

    final screenWidth = MediaQuery.of(context).size.width;
    final maxRowLen = rows.map((r) => r.length).reduce((a, b) => a > b ? a : b);
    final keyWidth = (screenWidth - 20) / (maxRowLen + 1); // +1 for margins
    final specialWidth = keyWidth * 1.5;

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          ...rows.map((row) {
                final isBottomRow = row == rows.last;
                final bottomRowChars = rows.last.length;
                // Calculate backspace width to fill remaining space and align with row above
                final backspaceWidth = isBottomRow
                    ? keyWidth * (maxRowLen - bottomRowChars) + 3.0 * (maxRowLen - bottomRowChars)
                    : specialWidth;
                return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...row.split('').map((c) {
                      final status = keyboardStatuses[c];
                      final disabled = status == LetterStatus.absent;
                      return _keyButton(
                        context,
                        c.toUpperCase(),
                        disabled ? null : () => notifier.addLetter(c),
                        width: keyWidth,
                        bg: status != null ? _statusColor(status) : null,
                      );
                    }),
                    if (isBottomRow)
                      _keyButton(context, '⌫', () => notifier.removeLetter(),
                          width: backspaceWidth),
                  ],
                ),
              );
              }),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: keyWidth * maxRowLen + 3.0 * maxRowLen,
                height: 48,
                child: Material(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => notifier.submitGuess(),
                    child: Center(
                      child: Text(
                        'ENTER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumericKeyboard(
    BuildContext context,
    String chars,
    Map<String, LetterStatus> statuses,
    dynamic notifier,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final numKeyWidth = (screenWidth - 20) / (chars.length + 1);
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: chars.split('').map((c) {
              final status = statuses[c];
              final disabled = status == LetterStatus.absent;
              return _keyButton(
                context,
                c,
                disabled ? null : () => notifier.addLetter(c),
                bg: status != null ? _statusColor(status) : null,
              );
            }).toList(),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _keyButton(context, '⌫', () => notifier.removeLetter(), width: 72),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: numKeyWidth * chars.length + 3.0 * chars.length,
                height: 48,
                child: Material(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => notifier.submitGuess(),
                    child: Center(
                      child: Text(
                        'ENTER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _keyButton(
    BuildContext context,
    String label,
    VoidCallback? onTap, {
    double? width,
    Color? bg,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final defaultWidth = (screenWidth - 20) / 12;
    final w = width ?? defaultWidth;
    final isDisabled = onTap == null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: SizedBox(
        width: w,
        height: 48,
        child: Opacity(
          opacity: isDisabled ? 0.3 : 1.0,
          child: Material(
            color: bg ?? Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: onTap,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: label.length == 1 ? 18 : 14,
                    color: bg != null ? Colors.white : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(LetterStatus status) {
    switch (status) {
      case LetterStatus.correct:
        return Colors.green;
      case LetterStatus.wrongPosition:
        return Colors.amber.shade700;
      case LetterStatus.absent:
        return Colors.grey.shade700;
    }
  }
}
