import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../providers/progress_provider.dart';
import '../models/game_variant.dart';
import '../utils/localization.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final locale = settings.locale;

    return Scaffold(
      appBar: AppBar(title: Text(tr('settings', locale))),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(tr('dark_mode', locale)),
            value: settings.isDarkMode,
            onChanged: (_) =>
                ref.read(settingsProvider.notifier).toggleDarkMode(),
          ),
          ListTile(
            title: Text(tr('language', locale)),
            trailing: SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'en', label: Text(tr('english', locale))),
                ButtonSegment(value: 'da', label: Text(tr('danish', locale))),
              ],
              selected: {locale},
              onSelectionChanged: (v) =>
                  ref.read(settingsProvider.notifier).setLocale(v.first),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              tr('reset_progress', locale),
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () => _confirmReset(context, ref, locale),
          ),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref, String locale) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr('reset_progress', locale)),
        content: Text(tr('reset_confirm', locale)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(tr('cancel', locale)),
          ),
          FilledButton(
            onPressed: () {
              for (final v in GameVariant.values) {
                ref.read(progressProvider((variant: v, locale: locale)).notifier).resetProgress();
              }
              Navigator.pop(ctx);
            },
            child: Text(tr('reset', locale)),
          ),
        ],
      ),
    );
  }
}
