import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

/// Dialog which asks the user to confirm an action.
class ConfirmDialog extends StatelessWidget {
  /// Dialog which asks the user to confirm an action.
  const ConfirmDialog({Key? key, required this.title, this.message, this.confirmText = "Confirm", this.cancelText = "Cancel", required this.onConfirm, this.onCancel}) : super(key: key);

  /// Title of the dialog.
  final String title;

  /// Message of the dialog.
  final String? message;

  /// Text of the confirm button.
  final String confirmText;

  /// Text of the cancel button.
  final String cancelText;

  /// Callback when the confirm button is pressed.
  final Function onConfirm;

  /// Callback when the cancel button is pressed.
  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: NcTitleText(title),
      content: message != null ? NcCaptionText(message!) : null,
      actions: [
        FilledButton(
          style: filledButtonStyle(),
          child: NcTitleText(
            confirmText,
            buttonText: true,
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
        Button(
          child: NcTitleText(
            cancelText,
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onCancel?.call();
          },
        )
      ],
      style: contentDialogStyle(),
    );
  }
}
