import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the Prompt Engineer resume PDF from the web root.
/// On Flutter web the file is served from `/Mirthavarshine_RP_Prompt_Engineer_Resume.pdf`.
class ResumeUtils {
  static const String fileName = 'Mirthavarshine_RP_Prompt_Engineer_Resume.pdf';

  static Uri get resumeUri {
    if (kIsWeb) {
      return Uri.base.resolve(fileName);
    }
    return Uri.parse('assets/$fileName');
  }

  static Future<void> openResume() async {
    final url = resumeUri;
    final launched = await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: kIsWeb ? '_blank' : null,
    );
    if (!launched) {
      throw Exception('Could not open resume');
    }
  }
}
