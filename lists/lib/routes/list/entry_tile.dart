import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

class EntryTile extends StatefulWidget {
  const EntryTile({Key? key, required this.entry}) : super(key: key);

  final MapEntry<String, String> entry;

  @override
  State<EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {
  bool _showContent = true;
  final flyoutController = FlyoutController();

  Future _copyToClipboard() async {
    if (!_showContent) return;

    setState(() {
      _showContent = false;
    });

    FlutterClipboard.copy(widget.entry.value);

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _showContent = true;
    });
  }

  // _showContextMenu(TapDownDetails details) {
  //   flyoutController.open = true;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _copyToClipboard,
      // onSecondaryTapDown: _showContextMenu,
      child: ContextMenuRegion(
        contextMenu: FlyoutContent(child: NcBodyText("Test")),
        child: Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_showContent)
                Expanded(
                  child: NcCaptionText(
                    widget.entry.key,
                    textAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                ),
              if (_showContent) NcSpacing.xs(),
              if (_showContent)
                Container(
                  height: 15,
                  width: 3,
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              if (_showContent) NcSpacing.xs(),
              if (_showContent)
                Expanded(
                  child: NcCaptionText(
                    widget.entry.value,
                    textAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                ),
              if (!_showContent)
                AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      'Copied!',
                      duration: Duration(milliseconds: 1000),
                      textStyle: NcBaseText.style(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
