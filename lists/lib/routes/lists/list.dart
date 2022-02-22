import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/routes/list/list.dart';
import 'package:nekolib_ui/core.dart';

class CollectionTile extends StatefulWidget {
  const CollectionTile({Key? key, required this.collection}) : super(key: key);

  final Collection collection;

  static const double iconSize = 60;

  @override
  State<CollectionTile> createState() => _CollectionTileState();
}

class _CollectionTileState extends State<CollectionTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ListRoute.routeName, arguments: widget.collection),
      child: Container(
        height: 170,
        width: 220,
        decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: tertiaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.collection.hasIcon
                ? SizedBox(
                    width: CollectionTile.iconSize,
                    height: CollectionTile.iconSize,
                    child: Image.file(
                      File(widget.collection.imgPath),
                    ),
                  )
                : Icon(
                    FluentIcons.lamp,
                    size: CollectionTile.iconSize,
                  ),
            NcSpacing.xs(),
            NcCaptionText(
              widget.collection.name,
              fontSize: 15,
            ),
            NcSpacing.medium(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.collection.requiresPassword)
                  Icon(
                    Icons.vpn_key,
                    color: tertiaryColor,
                    size: 15,
                  ),
                if (widget.collection.requiresPassword) NcSpacing.xs(),
                NcBodyText(
                  widget.collection.requiresPassword ? "Requires password" : "No password",
                  color: tertiaryColor,
                ),
              ],
            ),
            NcSpacing.medium(),
          ],
        ),
      ),
    );
  }
}
