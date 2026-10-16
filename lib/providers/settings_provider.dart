import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);

class SettingsState {
  final bool isDarkMode;
  final String locale; // 'en' or 'da'

  const SettingsState({this.isDarkMode = true, this.locale = 'en'});

  SettingsState copyWith({bool? isDarkMode, String? locale}) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  final Box _box;

  SettingsNotifier()
      : _box = Hive.box('settings'),
        super(const SettingsState()) {
    _load();
  }

  void _load() {
    state = SettingsState(
      isDarkMode: _box.get('isDarkMode', defaultValue: true) as bool,
      locale: _box.get('locale', defaultValue: 'en') as String,
    );
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    _box.put('isDarkMode', state.isDarkMode);
  }

  void setLocale(String locale) {
    state = state.copyWith(locale: locale);
    _box.put('locale', locale);
  }
}
