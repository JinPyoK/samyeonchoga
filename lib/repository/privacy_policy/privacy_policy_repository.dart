import 'package:isar/isar.dart';
import 'package:samyeonchoga/core/local_database/isar_base.dart';

part 'privacy_policy_repository.g.dart';

@collection
final class PrivacyPolicyRepository {
  Id id = Isarbase.fixedId;

  bool agree = false;

  /// 앱 첫 실행시 한 번 호출
  Future<void> readAgree() async {
    final result = await Isarbase.read(this);
    if (result == null) {
      return;
    } else {
      final privacyPolicy = result as PrivacyPolicyRepository;
      agree = privacyPolicy.agree;
    }
  }

  /// 동의 시 true 쓰기
  Future<void> writeAgree() async {
    await Isarbase.write(this);
  }
}
