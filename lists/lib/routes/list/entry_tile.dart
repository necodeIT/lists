import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/helpers/collection.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/widgets/context_menu.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:lists/widgets/vertical_divider.dart';
import 'package:nekolib_ui/core.dart';

class EntryTile extends StatefulWidget {
  const EntryTile({Key? key, required this.entry, required this.password, required this.collection}) : super(key: key);

  final String entry;
  final String password;
  final Collection collection;

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

    FlutterClipboard.copy(widget.collection[widget.entry]);

    await Future.delayed(FluentTheme.of(context).mediumAnimationDuration);

    setState(() {
      _showContent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _copyToClipboard,
      // onSecondaryTapDown: _showContextMenu,
      child: ContextMenuRegion(
        contextMenu: ContextMenu(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TooltipIconButton(
                tooltip: "Edit ${widget.collection[widget.entry]}",
                onPressed: () => editEntry(context, widget.password, widget.collection, widget.entry),
                icon: FluentIcons.ic_fluent_edit_24_filled,
              ),
              TooltipIconButton(
                tooltip: "Delete ${widget.collection[widget.entry]}",
                onPressed: () => removeEntry(context, widget.password, widget.collection, widget.entry),
                icon: FluentIcons.ic_fluent_delete_24_filled,
              ),
            ],
          ),
        ),
        child: Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _showContent ? primaryColor : adaptiveAccentColor.withOpacity(.5),
            border: Border.all(
              color: adaptiveAccentColor,
              style: _showContent ? BorderStyle.none : BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: _showContent ? kElevationToShadow[1] : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_showContent)
                Expanded(
                  child: NcCaptionText(
                    widget.entry,
                    textAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                ),
              if (_showContent) NcSpacing.xs(),
              if (_showContent) FluentVertivalDvider(),
              if (_showContent) NcSpacing.xs(),
              if (_showContent)
                Expanded(
                  child: NcCaptionText(
                    widget.collection[widget.entry],
                    textAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                ),
              if (_showContent)
                TooltipIconButton(
                  tooltip: "Copy",
                  icon: FluentIcons.ic_fluent_copy_24_filled,
                  onPressed: _copyToClipboard,
                ),
              if (!_showContent)
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    RotateAnimatedText(
                      'Copied!',
                      duration: FluentTheme.of(context).mediumAnimationDuration,
                      textStyle: NcBaseText.style(
                        fontWeight: FontWeight.w600,
                        color: adaptiveAccentColor,
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
