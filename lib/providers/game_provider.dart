import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/game_variant.dart';
import '../models/game_state.dart';
import '../data/puzzle_data.dart';

final gameStateProvider = StateNotifierProvider.family<GameNotifier, GameState,
    ({GameVariant variant, int level, String locale})>(
  (ref, params) => GameNotifier(params.variant, params.level, params.locale),
);

class GameNotifier extends StateNotifier<GameState> {
  final GameVariant variant;
  final String locale;
  final Box _box;
  final String _key;

  GameNotifier(this.variant, int level, this.locale)
      : _box = Hive.box('game_state'),
        _key = 'game_${variant.name}_${locale}_$level',
        super(GameState(
          level: level,
          answer: getAnswer(variant, level, locale: locale),
          maxGuesses: getMaxGuesses(variant, level),
          wordLength: getAnswer(variant, level, locale: locale).length,
        )) {
    _loadState();
  }

  void _loadState() {
    final hintsUsed = _box.get('${_key}_hints', defaultValue: 0) as int;
    final revealedList =
        (_box.get('${_key}_revealed', defaultValue: <int>[]) as List).cast<int>();
    final guessesList =
        (_box.get('${_key}_guesses', defaultValue: <String>[]) as List).cast<String>();

    if (hintsUsed > 0 || guessesList.isNotEmpty) {
      final won = guessesList.isNotEmpty &&
          guessesList.last.toLowerCase() == state.answer.toLowerCase();
      final lost = !won && guessesList.length >= state.maxGuesses;
      final revealed = revealedList.toSet();
      int selIdx = 0;
      for (int i = 0; i < state.wordLength; i++) {
        if (!revealed.contains(i)) {
          selIdx = i;
          break;
        }
      }
      state = state.copyWith(
        hintsUsed: hintsUsed,
        revealedIndices: revealed,
        guesses: guessesList,
        selectedIndex: selIdx,
        isWon: won,
        isLost: lost,
      );
    }
  }

  void _saveState() {
    _box.put('${_key}_hints', state.hintsUsed);
    _box.put('${_key}_revealed', state.revealedIndices.toList());
    _box.put('${_key}_guesses', state.guesses);
  }

  void addLetter(String letter) {
    if (state.isGameOver) return;
    if (state.userSlotsRemaining <= 0) return;

    // Find the target: selectedIndex if it's a free slot, otherwise next free slot
    int target = state.selectedIndex;
    if (target >= state.wordLength ||
        state.revealedIndices.contains(target) ||
        state.inputCells[target].isNotEmpty) {
      target = _nextEmptySlot(target);
      if (target == -1) return;
    }

    final cells = List<String>.from(state.inputCells);
    cells[target] = letter;
    final next = _nextEmptySlot(target + 1);
    state = state.copyWith(
      inputCells: cells,
      selectedIndex: next == -1 ? target : next,
    );
  }

  void removeLetter() {
    if (state.isGameOver) return;

    // If selected cell has user input, clear it
    final sel = state.selectedIndex;
    if (sel >= 0 && sel < state.wordLength &&
        !state.revealedIndices.contains(sel) &&
        state.inputCells[sel].isNotEmpty) {
      final cells = List<String>.from(state.inputCells);
      cells[sel] = '';
      state = state.copyWith(inputCells: cells);
      return;
    }

    // Otherwise, clear the last filled user slot before the cursor
    for (int i = sel - 1; i >= 0; i--) {
      if (!state.revealedIndices.contains(i) && state.inputCells[i].isNotEmpty) {
        final cells = List<String>.from(state.inputCells);
        cells[i] = '';
        state = state.copyWith(inputCells: cells, selectedIndex: i);
        return;
      }
    }
  }

  void selectIndex(int index) {
    if (state.isGameOver) return;
    if (index < 0 || index >= state.wordLength) return;
    if (state.revealedIndices.contains(index)) return;
    state = state.copyWith(selectedIndex: index);
  }

  void submitGuess() {
    if (state.isGameOver) return;
    if (state.userSlotsRemaining != 0) return;

    final guess = state.fullInput.toLowerCase();
    final newGuesses = [...state.guesses, guess];
    final won = guess == state.answer.toLowerCase();
    final lost = !won && newGuesses.length >= state.maxGuesses;

    state = state.copyWith(
      guesses: newGuesses,
      inputCells: List.filled(state.wordLength, ''),
      selectedIndex: _nextEmptySlotFor(0, newGuesses, state.revealedIndices),
      isWon: won,
      isLost: lost,
    );
    _saveState();
  }

  void reset() {
    state = GameState(
      level: state.level,
      answer: state.answer,
      maxGuesses: state.maxGuesses,
      wordLength: state.wordLength,
    );
    _saveState();
  }

  void retry() {
    state = GameState(
      level: state.level,
      answer: state.answer,
      maxGuesses: state.maxGuesses,
      wordLength: state.wordLength,
      hintsUsed: state.hintsUsed,
      revealedIndices: state.revealedIndices,
    );
    _saveState();
  }

  int _nextEmptySlot(int from) {
    for (int i = from; i < state.wordLength; i++) {
      if (!state.revealedIndices.contains(i) && state.inputCells[i].isEmpty) {
        return i;
      }
    }
    return -1;
  }

  int _nextEmptySlotFor(int from, List<String> guesses, Set<int> revealed) {
    for (int i = from; i < state.wordLength; i++) {
      if (!revealed.contains(i)) return i;
    }
    return 0;
  }

  int _nextEmptySlotAfter(int from, Set<int> revealed, List<String> cells) {
    for (int i = from; i < state.wordLength; i++) {
      if (!revealed.contains(i) && cells[i].isEmpty) return i;
    }
    // Wrap around
    for (int i = 0; i < from && i < state.wordLength; i++) {
      if (!revealed.contains(i) && cells[i].isEmpty) return i;
    }
    return 0;
  }

  void useHint() {
    if (state.isGameOver) return;
    if (state.hintsUsed >= 1) return;
    final confirmed = state.confirmedLetters;
    for (int i = 0; i < state.wordLength; i++) {
      if (!state.revealedIndices.contains(i) && confirmed[i].isEmpty) {
        final newRevealed = {...state.revealedIndices, i};
        // Clear any user input at the hint position
        final cells = List<String>.from(state.inputCells);
        cells[i] = '';
        // Adjust cursor if it was on the revealed position
        int sel = state.selectedIndex;
        if (sel == i) {
          sel = _nextEmptySlotAfter(sel + 1, newRevealed, cells);
        }
        state = state.copyWith(
          hintsUsed: state.hintsUsed + 1,
          revealedIndices: newRevealed,
          inputCells: cells,
          selectedIndex: sel,
        );
        _saveState();
        return;
      }
    }
  }
}
