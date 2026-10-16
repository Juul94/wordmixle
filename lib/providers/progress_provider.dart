import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/game_variant.dart';
import '../models/player_progress.dart';

final progressProvider = StateNotifierProvider.family<ProgressNotifier,
    PlayerProgress, ({GameVariant variant, String locale})>(
  (ref, params) => ProgressNotifier(params.variant, params.locale),
);

class ProgressNotifier extends StateNotifier<PlayerProgress> {
  final GameVariant variant;
  final String locale;
  final Box _box;

  String get _key => '${variant.hiveKey}_$locale';

  ProgressNotifier(this.variant, this.locale)
      : _box = Hive.box('progress'),
        super(const PlayerProgress()) {
    _load();
  }

  void _load() {
    final highest = _box.get('${_key}_highest', defaultValue: 0) as int;
    final unlockedList =
        (_box.get('${_key}_unlocked', defaultValue: <int>[1]) as List)
            .cast<int>();
    state = PlayerProgress(
      highestLevel: highest,
      unlockedLevels: unlockedList.toSet(),
    );
  }

  void completeLevel(int level) {
    state = state.completeLevel(level);
    _box.put('${_key}_highest', state.highestLevel);
    _box.put('${_key}_unlocked', state.unlockedLevels.toList());
  }

  void resetProgress() {
    state = const PlayerProgress();
    _box.put('${_key}_highest', 0);
    _box.put('${_key}_unlocked', <int>[1]);
  }
}
