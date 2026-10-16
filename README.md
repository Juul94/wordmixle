# WordMixle

A Flutter puzzle game with six Wordle-style variants and 100 levels in each. You guess a hidden word or number, and every guess gives color feedback. The levels get harder as you go, and the game can be played in English or Danish.

## Game variants

| Variant | How it works |
| --- | --- |
| 🔤 **Classic Wordle** | Guess the hidden 5-letter word. |
| 😀 **EmojiLink** | A set of emojis hints at the word. |
| 🔢 **Numberle** | Guess a hidden 5-digit number using a number keyboard. |
| 🖼️ **PictureWordle** | A single picture or emoji represents the word. |
| 🔗 **Synonym** | You get a synonym and guess the word that means the same. |
| 📖 **Definition** | You get a short definition and guess the word it describes. |

In every variant, the tiles turn **green** for the right character in the right position, **yellow** for a character that is in the answer but somewhere else, and **grey** for a character that isn't in the answer.

## Features

- **100 levels per variant**, which unlock one at a time as you complete them.
- **Difficulty curve**: levels 1–20 are easy (6 guesses), 21–50 medium (5 guesses) and 51–100 hard (4 guesses).
- **Hint**: reveals one letter that you haven't found yet. Each level has one hint.
- **Smart input**: tap any cell to move the cursor there. Revealed letters are locked. Letters you have confirmed are shown above the input row, and the letters you have placed in the wrong position are shown too.
- **Keyboard feedback**: each key shows the best status that letter has received so far.
- **English and Danish**: separate word lists for each language (including æ, ø and å), translated UI text, and separate progress per language.
- **Saved games**: guesses, hints and progress are saved, so you can leave a level and continue later.
- **Dark and light mode**, plus resetting your progress in the settings.
- **How to play** instructions for every variant.

## Tech stack

| Area | Technology |
| --- | --- |
| Framework | Flutter, Dart 3 |
| State management | Riverpod (`StateNotifierProvider.family`) |
| Persistence | Hive (local key-value boxes) |
| UI | Material 3, light and dark theme |
| Localization | A lightweight translation map (`tr(key, locale)`) |

## Architecture

```
lib/
  main.dart                    Hive init (game_state, progress, settings boxes), app and theme
  models/
    game_state.dart            Immutable game state and the feedback algorithm
    game_variant.dart          The six variants, icons and difficulty per level
    player_progress.dart       Unlocked levels and highest completed level
    letter_status.dart         absent / wrongPosition / correct
  providers/
    game_provider.dart         GameNotifier: input, cursor, submit, hint, retry, persistence
    progress_provider.dart     Level unlocking per variant and language
    settings_provider.dart     Dark mode and language
  data/
    puzzle_data.dart           English answers and clues, max guesses, allowed characters
    puzzle_data_da.dart        Danish answers and clues
  screens/                     Home (variant cards), level select, game, settings
  utils/                       Theme and translations
```

**Design choices**
- **Feedback uses two passes**, so repeated letters are scored correctly. The first pass marks exact matches green and reserves those positions. The second pass marks yellow only against answer letters that haven't been used yet.
- **Each game is a provider family keyed by `(variant, level, locale)`**, so every level has its own state and storage key. Switching language never mixes up progress.
- **The state is immutable** and updated with `copyWith`. Only the parts that need to survive a restart (guesses, hints and revealed positions) are written to Hive.

## Getting started

Requirements: the Flutter SDK (Dart 3.12+).

```bash
flutter pub get
flutter run
```

The game runs fully offline with no backend.
