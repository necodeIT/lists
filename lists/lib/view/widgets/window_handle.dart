import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/updater.dart';
import 'package:nekolib_ui/core.dart';

/// The app icon.
const kAppIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="338.5" height="291" viewBox="0 0 338.5 291">
  <defs>
    <linearGradient id="linear-gradient" x1="0.047" y1="0.039" x2="0.953" y2="0.96" gradientUnits="objectBoundingBox">
      <stop offset="0" stop-color="#f3a39e"/>
      <stop offset="1" stop-color="#c2827e"/>
    </linearGradient>
    <filter id="Background" x="0" y="0" width="291" height="291" filterUnits="userSpaceOnUse">
      <feOffset dy="3" input="SourceAlpha"/>
      <feGaussianBlur stdDeviation="26.5" result="blur"/>
      <feFlood flood-opacity="0.51"/>
      <feComposite operator="in" in2="blur"/>
      <feComposite in="SourceGraphic"/>
    </filter>
  </defs>
  <g id="Icon" transform="translate(79.83 20.467)">
    <g id="Stripes" transform="translate(59.952 0.143)">
      <path id="Rectangle_44" data-name="Rectangle 44" d="M0,0H199a0,0,0,0,1,0,0V34a26,26,0,0,1-26,26H26A26,26,0,0,1,0,34V0A0,0,0,0,1,0,0Z" transform="translate(-0.282 180.89)" fill="#aa726f"/>
      <rect id="Rectangle_43" data-name="Rectangle 43" width="199" height="59" transform="translate(-0.282 121.89)" fill="#c2827e"/>
      <rect id="Rectangle_45" data-name="Rectangle 45" width="199" height="59" transform="translate(-0.282 62.89)" fill="#db938e"/>
      <path id="Rectangle_41" data-name="Rectangle 41" d="M26,0H173a26,26,0,0,1,26,26V63a0,0,0,0,1,0,0H0a0,0,0,0,1,0,0V26A26,26,0,0,1,26,0Z" transform="translate(-0.282 -0.11)" fill="#f3a39e"/>
    </g>
    <g id="Name" transform="translate(0.099 56.341)">
      <g transform="matrix(1, 0, 0, 1, -79.93, -76.81)" filter="url(#Background)">
        <rect id="Background-2" data-name="Background" width="132" height="132" rx="26" transform="translate(79.5 76.5)" fill="url(#linear-gradient)"/>
      </g>
      <text id="L" transform="translate(38.571 100.693)" fill="rgba(255,255,255,0.87)" font-size="101" font-family="Roboto-Medium, Roboto" font-weight="500" letter-spacing="0.008em"><tspan x="0" y="0">L</tspan></text>
    </g>
  </g>
</svg>

''';

/// Wrapper for a themed window bar.
/// Using [bitsdojo_window](https://pub.dev/packages/bitsdojo_window).
class WindowHandle extends StatelessWidget {
  /// Wrapper for a themed window bar.
  /// Using [bitsdojo_window](https://pub.dev/packages/bitsdojo_window).
  const WindowHandle({Key? key, required this.child}) : super(key: key);

  /// The child widget.
  final Widget child;

  /// Static builder method for more convenient use.
  static Widget builder(BuildContext context, Widget? child) => WindowHandle(child: child!);

  @override
  Widget build(BuildContext context) {
    var defaultColors = WindowButtonColors(
      iconNormal: textColor,
      normal: Colors.transparent,
      iconMouseOver: buttonTextColor,
      mouseOver: neutralColor,
      iconMouseDown: buttonTextColor,
      mouseDown: neutralColor,
    );
    var closeColors = WindowButtonColors(
      mouseOver: errorColor,
      iconNormal: textColor,
      normal: Colors.transparent,
      iconMouseOver: buttonTextColor,
      iconMouseDown: buttonTextColor,
      mouseDown: errorColor,
    );

    return Column(
      children: [
        WindowTitleBarBox(
          child: Container(
            color: secondaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NcSpacing.small(),
                // Image.asset(
                //   img_app_icon,
                //   width: 16,
                //   height: 16,
                //   filterQuality: FilterQuality.high,
                //   isAntiAlias: true,
                // ),
                NcVectorImage(
                  code: kAppIconSvg,
                  width: 18,
                  height: 18,
                ),
                NcSpacing.xs(),
                Expanded(
                  child: MoveWindow(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: NcCaptionText(
                        Updater.appName,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                MinimizeWindowButton(colors: defaultColors),
                MaximizeWindowButton(colors: defaultColors),
                CloseWindowButton(colors: closeColors),
              ],
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
