import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key, required this.title, this.message, this.confirmText = "Confirm", this.cancelText = "Cancel", required this.onConfirm, this.onCancel}) : super(key: key);

  final String title;
  final String? message;
  final String confirmText;
  final String cancelText;
  final Function onConfirm;
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
