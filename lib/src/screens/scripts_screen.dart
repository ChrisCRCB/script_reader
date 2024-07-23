import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

import '../../gen/assets.gen.dart';
import 'script_screen.dart';

/// Show all the scripts which have been loaded.
class ScriptsScreen extends StatelessWidget {
  /// Create an instance.
  const ScriptsScreen({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final scripts = Assets.scripts.values..sort();
    return SimpleScaffold(
      title: 'Scripts',
      body: ListView.builder(
        itemBuilder: (final context, final index) {
          final name = scripts[index];
          final title = path.basenameWithoutExtension(name).titleCase;
          return ListTile(
            autofocus: index == 0,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            onTap: () async {
              final text = await DefaultAssetBundle.of(context).loadString(
                name,
              );
              final lines = text
                  .replaceAll('\r', '\n')
                  .split('\n')
                  .where((final line) => line.trim().isNotEmpty)
                  .toList();
              if (context.mounted) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (final _) =>
                        ScriptScreen(title: title, lines: lines),
                  ),
                );
              }
            },
          );
        },
        itemCount: scripts.length,
      ),
    );
  }
}
