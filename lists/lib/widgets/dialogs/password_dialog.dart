import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({Key? key, required this.collection, required this.onConfirm}) : super(key: key);

  final Collection collection;
  final Function(String) onConfirm;

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  bool _showPw = false;
  final TextEditingController _controller = TextEditingController();

  _toggleShowPw() {
    setState(() {
      _showPw = !_showPw;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: NcTitleText("Enter password for ${widget.collection.name}"),
      content: TextBox(
        placeholder: "Enter password",
        autofocus: true,
        onSubmitted: (_) => widget.onConfirm(_controller.text),
        obscureText: !_showPw,
        controller: _controller,
        suffix: TooltipIconButton(
          tooltip: _showPw ? "Hide password" : "Show password",
          icon: _showPw ? Ionicons.eye_off : Ionicons.eye,
          color: adaptiveAccentColor,
          onPressed: _toggleShowPw,
        ),
      ),
      actions: [
        FilledButton(
          style: filledButtonStyle(),
          child: NcTitleText(
            "Confirm",
            textAlign: TextAlign.center,
            buttonText: true,
          ),
          onPressed: () => widget.onConfirm(_controller.text),
        ),
        Button(
          child: NcTitleText(
            "Cancel",
            textAlign: TextAlign.center,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}