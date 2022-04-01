import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/assets/assets.dart';
import 'package:lists/models/collection.dart';
import 'package:lists/helpers/collection.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/view/widgets/context_menu.dart';
import 'package:lists/view/widgets/hover_region.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

/// Displays a collection.
class CollectionTile extends StatefulWidget {
  /// Displays a collection.
  const CollectionTile({Key? key, required this.collection}) : super(key: key);

  /// The collection to display.
  final Collection collection;

  /// The size of the collection icon.
  static const double iconSize = 80;

  @override
  State<CollectionTile> createState() => _CollectionTileState();
}

class _CollectionTileState extends State<CollectionTile> {
  @override
  Widget build(BuildContext context) {
    return ContextMenuRegion(
      contextMenu: ContextMenu(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TooltipIconButton.small(
                  tooltip: "Edit ${widget.collection.name}",
                  onPressed: () => updateCollection(context, widget.collection),
                  icon: FluentIcons.ic_fluent_edit_24_filled,
                ),
                TooltipIconButton.small(
                  tooltip: "Delete ${widget.collection.name}",
                  onPressed: () => deleteCollection(context, widget.collection),
                  icon: FluentIcons.ic_fluent_delete_24_filled,
                ),
              ],
            ),
            HoverRegion(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.ic_fluent_arrow_export_ltr_24_filled, size: 14),
                  NcSpacing.xs(),
                  NcCaptionText("Export", fontSize: 14),
                ],
              ),
              onTap: () => showPasswordDialog(context, widget.collection),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => showPasswordDialog(context, widget.collection),
        child: SizedBox(
          height: 260,
          width: 200,
          child: OffsetOnHover(
            duration: FluentTheme.of(context).fastAnimationDuration,
            curve: FluentTheme.of(context).animationCurve,
            // scale: 1.025,
            offset: Offset(0, -3),
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: CollectionTile.iconSize,
                          height: CollectionTile.iconSize,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: widget.collection.hasIcon
                                ? Image.memory(
                                    widget.collection.icon,
                                  )
                                : Image.asset(
                                    img_default_list_icon,
                                    color: textColor,
                                  ),
                          ),
                        ),
                        NcSpacing.xl(),
                        SizedBox(
                          width: double.infinity,
                          child: NcCaptionText(
                            widget.collection.name,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  NcSpacing.large(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NcBodyText('${widget.collection.length} item${widget.collection.length != 1 ? "s" : ""}'),
                      if (widget.collection.isProtected) NcSpacing.small(),
                      if (widget.collection.isProtected)
                        Tooltip(
                          message: 'This list is password protected',
                          child: Icon(
                            FluentIcons.ic_fluent_shield_24_regular,
                            color: textColor,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
