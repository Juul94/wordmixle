enum GameVariant {
  classicWordle,
  emojiLink,
  numberle,
  pictureWordle,
  synonym,
  definition,
}

extension GameVariantX on GameVariant {
  String label(String locale) {
    switch (this) {
      case GameVariant.classicWordle:
        return 'Classic Wordle';
      case GameVariant.emojiLink:
        return 'EmojiLink';
      case GameVariant.numberle:
        return 'Numberle';
      case GameVariant.pictureWordle:
        return 'PictureWordle';
      case GameVariant.synonym:
        return 'Synonym';
      case GameVariant.definition:
        return 'Definition';
    }
  }

  String get icon {
    switch (this) {
      case GameVariant.classicWordle:
        return '🔤';
      case GameVariant.emojiLink:
        return '😀';
      case GameVariant.numberle:
        return '🔢';
      case GameVariant.pictureWordle:
        return '🖼️';
      case GameVariant.synonym:
        return '🔗';
      case GameVariant.definition:
        return '📖';
    }
  }

  String get hiveKey => 'progress_$name';
}

enum Difficulty { easy, medium, hard }

Difficulty difficultyForLevel(int level) {
  if (level <= 20) return Difficulty.easy;
  if (level <= 50) return Difficulty.medium;
  return Difficulty.hard;
}
