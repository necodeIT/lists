import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

class AlertDialog extends StatelessWidget {
  const AlertDialog({Key? key, required this.title, required this.message}) : super(key: key);

  final String title;
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
