import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  static PackageInfo? _packageInfo;

  static Future<PackageInfo> getPackageInfo() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  static Future<String> getCurrentVersion() async {
    final info = await getPackageInfo();
    return info.version;
  }

  static Future<int> getBuildNumber() async {
    final info = await getPackageInfo();
    return int.tryParse(info.buildNumber) ?? 0;
  }

  static Future<String> getAppName() async {
    final info = await getPackageInfo();
    return info.appName;
  }

  static Future<void> openStoreListing() async {
    final info = await getPackageInfo();
    final packageName = info.packageName;
    final url = 'https://play.google.com/store/apps/details?id=$packageName';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
