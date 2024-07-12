import 'package:auto_size_text/auto_size_text.dart';
import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// A screen to show a single script.
class ScriptScreen extends StatefulWidget {
  /// Create an instance.
  const ScriptScreen({
    required this.title,
    required this.lines,
    super.key,
  });

  /// The title of the script.
  final String title;

  /// The lines in this script.
  final List<String> lines;

  /// Create state for this widget.
  @override
  ScriptScreenState createState() => ScriptScreenState();
}

/// State for [ScriptScreen].
class ScriptScreenState extends State<ScriptScreen> {
  /// The TTS to use.
  late final FlutterTts tts;

  /// The index of the line to use.
  late int index;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    tts = FlutterTts();
    index = 0;
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
    tts.stop();
  }

  /// Speak [text].
  Future<void> speak(final String text) async {
    await tts.stop();
    await tts.speak(text);
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final line = widget.lines[index];
    speak(line);
    return SimpleScaffold(
      title: widget.title,
      body: OrientationBuilder(
        builder: (final context, final orientation) {
          final buttons = <Widget>[
            ElevatedButton(
              onPressed: index == 0 ? null : () => setState(() => index--),
              child: const Icon(
                Icons.skip_previous_outlined,
                semanticLabel: 'Previous line',
              ),
            ),
            ElevatedButton(
              onPressed: () => speak(line),
              child: const Icon(
                Icons.play_circle_outline,
                semanticLabel: 'Replay',
              ),
            ),
            ElevatedButton(
              autofocus: true,
              onPressed: index >= (widget.lines.length - 1)
                  ? null
                  : () => setState(() => index++),
              child: const Icon(
                Icons.skip_next_outlined,
                semanticLabel: 'Next line',
              ),
            ),
          ];
          final textWidget = AutoSizeText(
            line,
            style: const TextStyle(
              fontSize: 20.0,
            ),
            overflow: TextOverflow.visible,
          );
          switch (orientation) {
            case Orientation.portrait:
              return Column(
                children: [
                  Expanded(child: textWidget),
                  Row(
                    children: buttons,
                  ),
                ],
              );
            case Orientation.landscape:
              return Row(
                children: [
                  Expanded(
                    child: textWidget,
                  ),
                  Column(
                    children: buttons,
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
