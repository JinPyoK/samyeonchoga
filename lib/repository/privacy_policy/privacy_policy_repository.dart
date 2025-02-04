import 'package:shared_preferences/shared_preferences.dart';

final class PrivacyPolicyRepository {
  Future<bool> getPrivacyPolicy() async {
    final pref = await SharedPreferences.getInstance();

    final bool? privacyPolicy = pref.getBool('privacyPolicy');

    return privacyPolicy ?? false;
  }

  Future<void> setPrivacyPolicy({required bool userAgree}) async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.setBool('privacyPolicy', true);
    } catch (_) {}
  }
}
