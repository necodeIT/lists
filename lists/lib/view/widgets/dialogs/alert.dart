import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

/// Dialog with a single button and a message.
class AlertDialog extends StatelessWidget {
  /// Dialog with a single button and a message.
  const AlertDialog({Key? key, required this.title, required this.message}) : super(key: key);

  /// Title of the dialog.
  final String title;

  /// Message of the dialog.
  final String message;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      scrollContent: true,
      title: NcTitleText(title),
      content: NcCaptionText(
        message,
        overflow: TextOverflow.visible,
      ),
      actions: [
        FilledButton(
          style: filledButtonStyle(),
          child: NcTitleText(
            'Dismiss',
            buttonText: true,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
      style: contentDialogStyle(),
    );
  }
}
