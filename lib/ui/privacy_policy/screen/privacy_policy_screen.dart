import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/privacy_policy/privacy_policy_instance.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/screen/home_navigation_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool? _privacyPolicyCheck = false;
  bool? _termsOfUseCheck = false;
  bool _isLoading = false;

  void _privacyPolicyChanged(bool? val) {
    _privacyPolicyCheck = val!;
    setState(() {});
  }

  void _termsOfUseChanged(bool? val) {
    _termsOfUseCheck = val!;
    setState(() {});
  }

  bool _isCheckedAll() {
    if (_privacyPolicyCheck != null && _termsOfUseCheck != null) {
      if (_privacyPolicyCheck! && _termsOfUseCheck!) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("개인 정보 처리 방침 및 이용 약관"),
        centerTitle: true,
        backgroundColor: whiteColor,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderTitle('개인정보 처리 방침'),
            _renderContents(
                '이 개인정보 처리 방침은 Kim Jin Pyo(이하 "서비스 제공자")가 무료 서비스로 제공하는 모바일 애플리케이션 "samyeonchoga"(이하 "애플리케이션")에 적용됩니다. 본 서비스는 "있는 그대로" 제공됩니다.'),
            _renderTitle('정보 수집 및 이용'),
            _renderContents('애플리케이션은 다운로드 및 사용 시 다음과 같은 정보를 수집할 수 있습니다:'),
            _renderContentsWithBullet('사용자의 기기 인터넷 프로토콜 주소(IP 주소)'),
            _renderContentsWithBullet(
                '애플리케이션 내 방문한 페이지, 방문 시간 및 날짜, 해당 페이지에서 머문 시간'),
            _renderContentsWithBullet('애플리케이션 사용 시간'),
            _renderContentsWithBullet('모바일 기기의 운영 체제 정보'),
            _renderContents(
                '애플리케이션은 사용자의 모바일 기기의 정확한 위치 정보를 수집하지 않습니다. 그러나 애플리케이션은 기기의 대략적인 위치 정보를 수집하며, 이는 다음과 같은 용도로 사용됩니다:'),
            _renderContentsWithBullet(
                '위치 기반 서비스: 서비스 제공자는 위치 데이터를 활용하여 맞춤형 콘텐츠, 관련 추천 및 위치 기반 서비스를 제공합니다.'),
            _renderContentsWithBullet(
                '분석 및 개선: 익명화된 위치 데이터는 사용자 행동 분석, 트렌드 파악 및 애플리케이션 성능 개선에 활용됩니다.'),
            _renderContentsWithBullet(
                '제3자 서비스 연계: 서비스 제공자는 주기적으로 익명화된 위치 데이터를 외부 서비스에 전송할 수 있으며, 이는 애플리케이션을 개선하고 최적화하는 데 사용됩니다.'),
            _renderContents(
                '서비스 제공자는 중요한 공지사항, 필수 알림 및 마케팅 프로모션을 제공하기 위해 사용자가 제공한 정보를 이용할 수 있습니다.'),
            _renderContents(
                '보다 나은 사용자 경험을 제공하기 위해, 애플리케이션은 특정한 개인정보를 요청할 수 있으며, 이 정보는 본 개인정보 처리 방침에 따라 보관 및 활용됩니다.'),
            _renderTitle('제3자 접근 권한'),
            _renderContents(
                '서비스 제공자는 주기적으로 익명화된 데이터를 외부 서비스에 전송하여 애플리케이션 및 서비스를 개선하는 데 활용할 수 있습니다. 또한, 본 개인정보 처리 방침에서 설명된 방식으로 사용자의 정보를 제3자와 공유할 수 있습니다.'),
            _renderContents(
                '애플리케이션은 데이터 처리와 관련하여 자체적인 개인정보 처리 방침을 가진 제3자 서비스를 사용합니다. 아래는 애플리케이션이 사용하는 제3자 서비스의 개인정보 처리 방침 링크입니다:'),
            _renderContentsWithBullet('Google Play 서비스'),
            _renderContentsWithBullet('AdMob'),
            _renderContents(
                '서비스 제공자는 다음과 같은 경우 사용자 제공 정보 및 자동 수집 정보를 공개할 수 있습니다:'),
            _renderContentsWithBullet('법적 요구에 따라 소환장 또는 유사한 법적 절차를 준수해야 하는 경우'),
            _renderContentsWithBullet(
                '서비스 제공자의 권리를 보호하거나, 사용자 또는 타인의 안전을 보호하며, 사기 행위를 조사하거나, 정부 요청에 응답해야 하는 경우'),
            _renderContentsWithBullet(
                '서비스 제공자를 대신하여 업무를 수행하는 신뢰할 수 있는 서비스 제공업체와의 협력 시, 해당 업체가 정보를 독립적으로 사용하지 않고 본 개인정보 처리 방침을 준수하기로 동의한 경우'),
            _renderTitle('옵트아웃 권리'),
            _renderContents(
                '사용자는 애플리케이션을 삭제함으로써 정보 수집을 중단할 수 있습니다. 기기의 표준 삭제 절차 또는 모바일 앱 마켓, 네트워크를 통해 애플리케이션을 제거할 수 있습니다.'),
            _renderTitle('데이터 보관 정책'),
            _renderContents(
                '서비스 제공자는 사용자가 애플리케이션을 이용하는 동안 및 합리적인 기간 동안 사용자 제공 데이터를 보관합니다. 애플리케이션을 통해 제공한 데이터를 삭제하고 싶은 경우, kjp00552277@gmail.com으로 연락하면 합리적인 기간 내에 응답하겠습니다.'),
            _renderTitle('어린이 개인정보 보호'),
            _renderContents(
                '서비스 제공자는 13세 미만 어린이로부터 의도적으로 데이터를 수집하거나 마케팅을 수행하지 않습니다.'),
            _renderContents(
                '애플리케이션은 13세 미만의 사용자를 대상으로 하지 않으며, 서비스 제공자는 13세 미만 어린이의 개인정보를 의도적으로 수집하지 않습니다. 만약 13세 미만 어린이가 개인정보를 제공한 사실을 알게 될 경우, 해당 정보를 즉시 서버에서 삭제하겠습니다. 부모 또는 보호자가 자녀가 개인정보를 제공한 사실을 인지한 경우, kjp00552277@gmail.com으로 연락해 주시면 적절한 조치를 취하겠습니다.'),
            _renderTitle('보안'),
            _renderContents(
                '서비스 제공자는 사용자의 정보 기밀성을 보호하기 위해 노력하고 있습니다. 서비스 제공자는 물리적, 전자적 및 절차적 보안 조치를 통해 정보를 안전하게 보호합니다.'),
            _renderTitle('변경 사항'),
            _renderContents(
                '본 개인정보 처리 방침은 필요에 따라 업데이트될 수 있습니다. 변경 사항이 있을 경우, 본 페이지를 통해 새로운 개인정보 처리 방침을 게시할 것입니다. 사용자는 본 개인정보 처리 방침을 정기적으로 확인해야 하며, 애플리케이션을 계속 사용하는 경우 변경 사항을 승인한 것으로 간주됩니다.'),
            _renderContents('본 개인정보 처리 방침은 2024년 12월 30일부터 유효합니다.'),
            _renderTitle('사용자의 동의'),
            _renderContents(
                '애플리케이션을 이용함으로써, 사용자는 본 개인정보 처리 방침에 따라 정보가 처리되는 것에 동의하는 것으로 간주됩니다.'),
            _renderTitle('문의하기'),
            _renderContents(
                '애플리케이션 이용 중 개인정보 보호에 대한 질문이 있거나 본 개인정보 처리 방침에 대한 문의 사항이 있는 경우, 서비스 제공자에게 **kjp00552277@gmail.com**으로 연락해 주시기 바랍니다.'),
            _renderContents(
                '본 개인정보 처리 방침은 App Privacy Policy Generator를 이용하여 생성되었습니다.'),
            _renderCheckBox(
              _privacyPolicyCheck,
              "위 개인 정보 처리 방침에 대하여 확인 및 동의합니다.",
              _privacyPolicyChanged,
            ),
            _renderDivider(),
            _renderTitle('이용 약관'),
            _renderContents(
                '본 이용 약관은 Kim Jin Pyo(이하 "서비스 제공자")가 무료 서비스로 제공하는 모바일 애플리케이션 "samyeonchoga"(이하 "애플리케이션")에 적용됩니다.'),
            const SizedBox(height: 30),
            _renderContents(
                '애플리케이션을 다운로드하거나 사용하는 경우, 사용자는 본 이용 약관에 자동으로 동의하는 것입니다. 애플리케이션을 사용하기 전에 반드시 본 약관을 자세히 읽고 이해하시기 바랍니다. 애플리케이션 또는 그 일부, 서비스 제공자의 상표를 무단으로 복사하거나 수정하는 행위는 엄격히 금지됩니다. 또한, 애플리케이션의 소스 코드를 추출하거나, 다른 언어로 번역하거나, 파생 버전을 생성하는 행위도 허용되지 않습니다. 애플리케이션과 관련된 모든 상표, 저작권, 데이터베이스 권리 및 기타 지적 재산권은 서비스 제공자에게 귀속됩니다.'),
            _renderContents(
                '서비스 제공자는 애플리케이션을 최대한 유용하고 효율적으로 유지하기 위해 노력하고 있으며, 이에 따라 언제든지 애플리케이션을 수정하거나 서비스에 대한 요금을 부과할 권리를 보유합니다. 단, 애플리케이션이나 서비스에 대한 요금이 발생하는 경우, 서비스 제공자는 이를 명확하게 사용자에게 고지할 것입니다.'),
            _renderContents(
                '애플리케이션은 서비스를 제공하기 위해 사용자가 제공한 개인정보를 저장하고 처리합니다. 사용자는 자신의 휴대전화 및 애플리케이션에 대한 접근 보안을 유지할 책임이 있습니다. 서비스 제공자는 사용자의 기기에서 소프트웨어 제한 및 보안 기능을 제거하는 **탈옥(jailbreaking) 또는 루팅(rooting)**을 강력히 권장하지 않습니다. 이러한 행위는 기기를 악성 코드, 바이러스 및 보안 위협에 노출시키고, 애플리케이션이 정상적으로 작동하지 않을 가능성이 있습니다.'),
            _renderContents(
                '애플리케이션은 자체적으로 운영되는 것이 아니라 일부 제3자 서비스를 이용합니다. 이러한 제3자 서비스에는 자체적인 이용 약관이 적용되므로, 아래 링크를 참고하시기 바랍니다:'),
            _renderContentsWithBullet('Google Play 서비스'),
            _renderContentsWithBullet('AdMob'),
            _renderTitle('책임 제한'),
            _renderContents(
                '서비스 제공자는 특정 사항에 대한 책임을 지지 않습니다. 예를 들어, 애플리케이션의 일부 기능은 Wi-Fi 또는 모바일 네트워크를 통한 인터넷 연결이 필요합니다. 사용자의 데이터 요금 초과나 인터넷 연결 불가로 인해 애플리케이션이 정상적으로 작동하지 않는 경우, 서비스 제공자는 이에 대한 책임을 지지 않습니다.'),
            _renderContents(
                'Wi-Fi가 아닌 환경에서 애플리케이션을 사용할 경우, 사용자의 모바일 네트워크 제공업체의 요금 정책이 적용됩니다. 따라서 사용자는 애플리케이션을 사용할 때 발생하는 모든 데이터 요금(로밍 요금 포함)에 대한 책임을 져야 합니다. 또한, 사용자가 기기 요금제의 청구자가 아닐 경우, 청구자로부터 사용 허가를 받았다고 간주됩니다.'),
            _renderContents(
                '사용자가 애플리케이션을 이용하는 과정에서 발생하는 일부 상황에 대해서도 서비스 제공자는 책임을 지지 않습니다. 예를 들어, 사용자의 기기가 충전되지 않아 서비스에 접근할 수 없는 경우, 이는 사용자의 책임입니다.'),
            _renderContents(
                '애플리케이션의 정보 정확성을 유지하기 위해 노력하고 있지만, 서비스 제공자는 일부 정보를 제3자로부터 제공받아 사용자에게 제공하므로, 해당 정보의 정확성이나 신뢰성에 대해 보장할 수 없습니다. 따라서 애플리케이션의 기능을 전적으로 신뢰하여 발생한 손해에 대해 서비스 제공자는 책임을 지지 않습니다.'),
            _renderTitle('애플리케이션 업데이트 및 종료'),
            _renderContents(
                '서비스 제공자는 애플리케이션을 필요에 따라 업데이트할 수 있습니다. 운영 체제 요구 사항이 변경될 경우, 사용자는 지속적인 애플리케이션 사용을 위해 업데이트를 다운로드해야 할 수 있습니다. 단, 서비스 제공자는 애플리케이션이 항상 최신 운영 체제와 호환됨을 보장하지 않습니다. 사용자는 제공된 업데이트를 수락하고 적용할 것에 동의합니다.'),
            _renderContents(
                '서비스 제공자는 언제든지 애플리케이션 제공을 중단할 수 있으며, 사전 공지 없이 사용자의 애플리케이션 이용을 종료할 권리를 가집니다. 애플리케이션이 종료되는 경우, (a) 본 이용 약관에서 부여된 권리와 라이선스는 종료되며, (b) 사용자는 애플리케이션 사용을 중단하고 필요 시 기기에서 삭제해야 합니다.'),
            _renderTitle('이용 약관 변경 사항'),
            _renderContents(
                '서비스 제공자는 필요에 따라 본 이용 약관을 업데이트할 수 있습니다. 따라서 사용자는 정기적으로 본 페이지를 검토하는 것이 좋습니다. 서비스 제공자는 새로운 이용 약관을 본 페이지에 게시함으로써 변경 사항을 공지할 것입니다.'),
            _renderContents('본 이용 약관은 2024년 12월 30일부터 유효합니다.'),
            _renderTitle('문의하기'),
            _renderContents(
                '본 이용 약관에 대한 질문이나 제안이 있는 경우, kjp00552277@gmail.com으로 서비스 제공자에게 연락해 주시기 바랍니다.'),
            _renderContents(
                '본 이용 약관 페이지는 App Privacy Policy Generator를 이용하여 생성되었습니다.'),
            _renderCheckBox(
              _termsOfUseCheck,
              '위 이용 약관에 대하여 확인 및 동의합니다.',
              _termsOfUseChanged,
            ),
            _renderDivider(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _isCheckedAll()
                        ? () async {
                            if (_isLoading == false) {
                              _isLoading = true;
                              setState(() {});

                              privacyPolicy.agree = true;
                              await privacyPolicy.writeAgree();

                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeNavigationScreen()),
                                  (route) => false,
                                );
                              }
                            }
                          }
                        : null,
                    child: Text(_isLoading ? "접속중..." : "동의하고 시작하기"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _renderTitle(String title) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );

Widget _renderContents(String contents) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        contents,
        style: const TextStyle(fontSize: 14),
      ),
    );

Widget _renderContentsWithBullet(String contents) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '●',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 260 * wu,
            child: Text(
              contents,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );

Widget _renderCheckBox(
        bool? checkValue, String agreement, void Function(bool?)? onCheck) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Checkbox(
            value: checkValue,
            onChanged: onCheck,
            activeColor: woodColor,
          ),
          const SizedBox(width: 10),
          SizedBox(width: 250 * wu, child: Text(agreement)),
        ],
      ),
    );

Widget _renderDivider() => const Padding(
      padding: EdgeInsets.all(30.0),
      child: Divider(color: blackColor),
    );
