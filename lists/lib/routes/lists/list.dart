import 'dart:io';

import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:lists/assets/assets.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/list/list.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

class CollectionTile extends StatefulWidget {
  const CollectionTile({Key? key, required this.collection}) : super(key: key);

  final Collection collection;

  static const double iconSize = 80;

  @override
  State<CollectionTile> createState() => _CollectionTileState();
}

class _CollectionTileState extends State<CollectionTile> {
  @override
  Widget build(BuildContext context) {
    return ContextMenuRegion(
      contextMenu: FlyoutContent(
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TooltipIconButton(
              tooltip: "Edit ${widget.collection.name}",
              onPressed: () {},
              icon: FluentIcons.edit,
            ),
            TooltipIconButton(
              tooltip: "Delete ${widget.collection.name}",
              onPressed: () {},
              icon: FluentIcons.delete,
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => showPasswordDialog(context, widget.collection),
        child: Container(
          height: 260,
          width: 200,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: kElevationToShadow[2],
          ),
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
                            : Image.asset(img_default_list_icon),
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
                children: [
                  if (widget.collection.isPasswordProtected)
                    Tooltip(
                      message: 'This list is password protected',
                      child: Icon(
                        Icons.vpn_key,
                        color: textColor,
                        size: 15,
                      ),
                    ),
                  if (widget.collection.isPasswordProtected) NcSpacing.small(),
                  NcBodyText('${widget.collection.length} item${widget.collection.length != 1 ? "s" : ""}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
