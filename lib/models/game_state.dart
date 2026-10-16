import 'letter_status.dart';

class GameState {
  final int level;
  final String answer;
  final int maxGuesses;
  final int wordLength;
  final List<String> guesses;
  final List<String> inputCells; // length = wordLength, each '' or single char
  final int selectedIndex; // cursor position on current row
  final bool isWon;
  final bool isLost;
  final int hintsUsed;
  final Set<int> revealedIndices;

  GameState({
    required this.level,
    required this.answer,
    this.maxGuesses = 6,
    this.wordLength = 5,
    this.guesses = const [],
    List<String>? inputCells,
    this.selectedIndex = 0,
    this.isWon = false,
    this.isLost = false,
    this.hintsUsed = 0,
    this.revealedIndices = const {},
  }) : inputCells = inputCells ?? List.filled(wordLength, '');

  GameState copyWith({
    List<String>? guesses,
    List<String>? inputCells,
    int? selectedIndex,
    bool? isWon,
    bool? isLost,
    int? hintsUsed,
    Set<int>? revealedIndices,
  }) {
    return GameState(
      level: level,
      answer: answer,
      maxGuesses: maxGuesses,
      wordLength: wordLength,
      guesses: guesses ?? this.guesses,
      inputCells: inputCells ?? this.inputCells,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isWon: isWon ?? this.isWon,
      isLost: isLost ?? this.isLost,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      revealedIndices: revealedIndices ?? this.revealedIndices,
    );
  }

  int get hintsRemaining => 1 - hintsUsed;

  bool get isGameOver => isWon || isLost;

  int get userSlotsRemaining {
    int filled = 0;
    for (int i = 0; i < wordLength; i++) {
      if (!revealedIndices.contains(i) && inputCells[i].isNotEmpty) filled++;
    }
    return wordLength - revealedIndices.length - filled;
  }

  String get fullInput {
    final result = List<String>.from(inputCells);
    for (final idx in revealedIndices) {
      if (idx < wordLength) result[idx] = answer[idx];
    }
    return result.join();
  }

  /// Position-aware input: returns a list of length wordLength with letters or ''
  List<String> get displayCells {
    final result = List<String>.from(inputCells);
    for (final idx in revealedIndices) {
      if (idx < wordLength) result[idx] = answer[idx];
    }
    return result;
  }

  /// Letters confirmed correct (green) from previous guesses
  List<String> get confirmedLetters {
    final result = List.filled(wordLength, '');
    for (final guess in guesses) {
      final fb = feedbackFor(guess);
      for (int i = 0; i < wordLength && i < guess.length; i++) {
        if (fb[i] == LetterStatus.correct) {
          result[i] = guess[i];
        }
      }
    }
    for (final idx in revealedIndices) {
      if (idx < wordLength) result[idx] = answer[idx];
    }
    return result;
  }

  List<LetterStatus> feedbackFor(String guess) {
    final result = List.filled(wordLength, LetterStatus.absent);
    final answerChars = answer.split('');
    final guessChars = guess.split('');
    final used = List.filled(wordLength, false);

    // Green pass
    for (int i = 0; i < wordLength; i++) {
      if (i < guessChars.length && guessChars[i] == answerChars[i]) {
        result[i] = LetterStatus.correct;
        used[i] = true;
      }
    }

    // Yellow pass
    for (int i = 0; i < wordLength; i++) {
      if (result[i] == LetterStatus.correct) continue;
      if (i >= guessChars.length) continue;
      for (int j = 0; j < wordLength; j++) {
        if (!used[j] && guessChars[i] == answerChars[j]) {
          result[i] = LetterStatus.wrongPosition;
          used[j] = true;
          break;
        }
      }
    }

    return result;
  }

  Map<String, LetterStatus> get keyboardStatuses {
    final map = <String, LetterStatus>{};
    for (final guess in guesses) {
      final fb = feedbackFor(guess);
      for (int i = 0; i < guess.length && i < fb.length; i++) {
        final letter = guess[i];
        final status = fb[i];
        final existing = map[letter];
        if (existing == null ||
            status.index > existing.index) {
          map[letter] = status;
        }
      }
    }
    return map;
  }
}
