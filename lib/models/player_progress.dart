class PlayerProgress {
  final int highestLevel;
  final Set<int> unlockedLevels;

  const PlayerProgress({
    this.highestLevel = 0,
    this.unlockedLevels = const {1},
  });

  PlayerProgress copyWith({int? highestLevel, Set<int>? unlockedLevels}) {
    return PlayerProgress(
      highestLevel: highestLevel ?? this.highestLevel,
      unlockedLevels: unlockedLevels ?? this.unlockedLevels,
    );
  }

  bool isUnlocked(int level) => unlockedLevels.contains(level);

  PlayerProgress completeLevel(int level) {
    final newUnlocked = {...unlockedLevels, level, level + 1};
    return PlayerProgress(
      highestLevel: level > highestLevel ? level : highestLevel,
      unlockedLevels: newUnlocked,
    );
  }
}
