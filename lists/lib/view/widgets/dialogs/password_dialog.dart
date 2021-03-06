import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/collection.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

/// Dialog to enter the password to access a collection.
class PasswordDialog extends StatefulWidget {
  /// Dialog to enter the password to access a collection.
  const PasswordDialog({Key? key, required this.collection, required this.onConfirm}) : super(key: key);

  /// Collection to access.
  final Collection collection;

  /// Callback when the password is confirmed.
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
        style: textBoxTextStyle(),
        placeholder: "Enter password",
        autofocus: true,
        onSubmitted: (_) => widget.onConfirm(_controller.text),
        obscureText: !_showPw,
        controller: _controller,
        suffix: TooltipIconButton.small(
          tooltip: _showPw ? "Hide password" : "Show password",
          icon: _showPw ? FluentIcons.ic_fluent_eye_hide_24_filled : FluentIcons.ic_fluent_eye_show_24_filled,
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
