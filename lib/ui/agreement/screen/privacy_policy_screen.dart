import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/agreement/screen/terms_of_use_screen.dart';
import 'package:samyeonchoga/ui/agreement/widget/agreement_contents.dart';
import 'package:samyeonchoga/ui/agreement/widget/agreement_contents_bullet.dart';
import 'package:samyeonchoga/ui/agreement/widget/agreement_title.dart';
import 'package:samyeonchoga/ui/common/widget/launch_url_text_button.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "개인 정보 처리 방침",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AgreementContents(
                contents:
                    '이 개인정보 처리 방침은 Kim Jin Pyo(이하 "서비스 제공자")가 무료 서비스로 제공하는 모바일 애플리케이션 "samyeonchoga"(이하 "애플리케이션")에 적용됩니다. 본 서비스는 "있는 그대로" 제공됩니다.'),
            const AgreementTitle(title: '정보 수집 및 이용'),
            const AgreementContents(
                contents: '애플리케이션은 다운로드 및 사용 시 다음과 같은 정보를 수집할 수 있습니다:'),
            const AgreementContentsBullet(
                contents: '사용자의 기기 인터넷 프로토콜 주소(IP 주소)'),
            const AgreementContentsBullet(
                contents: '애플리케이션 내 방문한 페이지, 방문 시간 및 날짜, 해당 페이지에서 머문 시간'),
            const AgreementContentsBullet(contents: '애플리케이션 사용 시간'),
            const AgreementContentsBullet(contents: '모바일 기기의 운영 체제 정보'),
            const AgreementContents(
                contents:
                    '애플리케이션은 사용자의 모바일 기기의 정확한 위치 정보를 수집하지 않습니다. 그러나 애플리케이션은 기기의 대략적인 위치 정보를 수집하며, 이는 다음과 같은 용도로 사용됩니다:'),
            const AgreementContentsBullet(
                contents:
                    '위치 기반 서비스: 서비스 제공자는 위치 데이터를 활용하여 맞춤형 콘텐츠, 관련 추천 및 위치 기반 서비스를 제공합니다.'),
            const AgreementContentsBullet(
                contents:
                    '분석 및 개선: 익명화된 위치 데이터는 사용자 행동 분석, 트렌드 파악 및 애플리케이션 성능 개선에 활용됩니다.'),
            const AgreementContentsBullet(
                contents:
                    '제3자 서비스 연계: 서비스 제공자는 주기적으로 익명화된 위치 데이터를 외부 서비스에 전송할 수 있으며, 이는 애플리케이션을 개선하고 최적화하는 데 사용됩니다.'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 중요한 공지사항, 필수 알림 및 마케팅 프로모션을 제공하기 위해 사용자가 제공한 정보를 이용할 수 있습니다.'),
            const AgreementContents(
                contents:
                    '보다 나은 사용자 경험을 제공하기 위해, 애플리케이션은 특정한 개인정보를 요청할 수 있으며, 이 정보는 본 개인정보 처리 방침에 따라 보관 및 활용됩니다.'),
            const AgreementTitle(title: '제3자 접근 권한'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 주기적으로 익명화된 데이터를 외부 서비스에 전송하여 애플리케이션 및 서비스를 개선하는 데 활용할 수 있습니다. 또한, 본 개인정보 처리 방침에서 설명된 방식으로 사용자의 정보를 제3자와 공유할 수 있습니다.'),
            const AgreementContents(
                contents:
                    '애플리케이션은 데이터 처리와 관련하여 자체적인 개인정보 처리 방침을 가진 제3자 서비스를 사용합니다. 아래는 애플리케이션이 사용하는 제3자 서비스의 개인정보 처리 방침 링크입니다:'),
            const LaunchUrlTextButton(
              url: 'https://policies.google.com/privacy',
              text: "Google Play 서비스",
            ),
            const LaunchUrlTextButton(
              url: 'https://support.google.com/admob/answer/6128543?hl=en',
              text: "AdMob",
            ),
            const AgreementContents(
                contents:
                    '서비스 제공자는 다음과 같은 경우 사용자 제공 정보 및 자동 수집 정보를 공개할 수 있습니다:'),
            const AgreementContentsBullet(
                contents: '법적 요구에 따라 소환장 또는 유사한 법적 절차를 준수해야 하는 경우'),
            const AgreementContentsBullet(
                contents:
                    '서비스 제공자의 권리를 보호하거나, 사용자 또는 타인의 안전을 보호하며, 사기 행위를 조사하거나, 정부 요청에 응답해야 하는 경우'),
            const AgreementContentsBullet(
                contents:
                    '서비스 제공자를 대신하여 업무를 수행하는 신뢰할 수 있는 서비스 제공업체와의 협력 시, 해당 업체가 정보를 독립적으로 사용하지 않고 본 개인정보 처리 방침을 준수하기로 동의한 경우'),
            const AgreementTitle(title: '옵트아웃 권리'),
            const AgreementContents(
                contents:
                    '사용자는 애플리케이션을 삭제함으로써 정보 수집을 중단할 수 있습니다. 기기의 표준 삭제 절차 또는 모바일 앱 마켓, 네트워크를 통해 애플리케이션을 제거할 수 있습니다.'),
            const AgreementTitle(title: '데이터 보관 정책'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 사용자가 애플리케이션을 이용하는 동안 및 합리적인 기간 동안 사용자 제공 데이터를 보관합니다. 애플리케이션을 통해 제공한 데이터를 삭제하고 싶은 경우, kjp00552277@gmail.com으로 연락하면 합리적인 기간 내에 응답하겠습니다.'),
            const AgreementTitle(title: '어린이 개인정보 보호'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 13세 미만 어린이로부터 의도적으로 데이터를 수집하거나 마케팅을 수행하지 않습니다.'),
            const AgreementContents(
                contents:
                    '애플리케이션은 13세 미만의 사용자를 대상으로 하지 않으며, 서비스 제공자는 13세 미만 어린이의 개인정보를 의도적으로 수집하지 않습니다. 만약 13세 미만 어린이가 개인정보를 제공한 사실을 알게 될 경우, 해당 정보를 즉시 서버에서 삭제하겠습니다. 부모 또는 보호자가 자녀가 개인정보를 제공한 사실을 인지한 경우, kjp00552277@gmail.com으로 연락해 주시면 적절한 조치를 취하겠습니다.'),
            const AgreementTitle(title: '보안'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 사용자의 정보 기밀성을 보호하기 위해 노력하고 있습니다. 서비스 제공자는 물리적, 전자적 및 절차적 보안 조치를 통해 정보를 안전하게 보호합니다.'),
            const AgreementTitle(title: '변경 사항'),
            const AgreementContents(
                contents:
                    '본 개인정보 처리 방침은 필요에 따라 업데이트될 수 있습니다. 변경 사항이 있을 경우, 본 페이지를 통해 새로운 개인정보 처리 방침을 게시할 것입니다. 사용자는 본 개인정보 처리 방침을 정기적으로 확인해야 하며, 애플리케이션을 계속 사용하는 경우 변경 사항을 승인한 것으로 간주됩니다.'),
            const AgreementContents(
                contents: '본 개인정보 처리 방침은 2024년 12월 30일부터 유효합니다.'),
            const AgreementTitle(title: '사용자의 동의'),
            const AgreementContents(
                contents:
                    '애플리케이션을 이용함으로써, 사용자는 본 개인정보 처리 방침에 따라 정보가 처리되는 것에 동의하는 것으로 간주됩니다.'),
            const AgreementTitle(title: '문의하기'),
            const AgreementContents(
                contents:
                    '애플리케이션 이용 중 개인정보 보호에 대한 질문이 있거나 본 개인정보 처리 방침에 대한 문의 사항이 있는 경우, 서비스 제공자에게 **kjp00552277@gmail.com**으로 연락해 주시기 바랍니다.'),
            const AgreementContents(
                contents:
                    '본 개인정보 처리 방침은 App Privacy Policy Generator를 이용하여 생성되었습니다.'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsOfUseScreen(),
                        ),
                      );
                    },
                    child: const Text("위 내용을 확인 및 동의합니다 1/2"),
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
