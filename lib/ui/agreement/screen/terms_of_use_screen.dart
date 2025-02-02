import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/privacy_policy/privacy_policy_instance.dart';
import 'package:samyeonchoga/ui/agreement/widget/agreement_contents.dart';
import 'package:samyeonchoga/ui/agreement/widget/agreement_title.dart';
import 'package:samyeonchoga/ui/common/screen/home_navigation_screen.dart';
import 'package:samyeonchoga/ui/common/widget/launch_url_text_button.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "이용 약관",
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
                    '본 이용 약관은 Kim Jin Pyo(이하 "서비스 제공자")가 무료 서비스로 제공하는 모바일 애플리케이션 "samyeonchoga"(이하 "애플리케이션")에 적용됩니다.'),
            const SizedBox(height: 30),
            const AgreementContents(
                contents:
                    '애플리케이션을 다운로드하거나 사용하는 경우, 사용자는 본 이용 약관에 자동으로 동의하는 것입니다. 애플리케이션을 사용하기 전에 반드시 본 약관을 자세히 읽고 이해하시기 바랍니다. 애플리케이션 또는 그 일부, 서비스 제공자의 상표를 무단으로 복사하거나 수정하는 행위는 엄격히 금지됩니다. 또한, 애플리케이션의 소스 코드를 추출하거나, 다른 언어로 번역하거나, 파생 버전을 생성하는 행위도 허용되지 않습니다. 애플리케이션과 관련된 모든 상표, 저작권, 데이터베이스 권리 및 기타 지적 재산권은 서비스 제공자에게 귀속됩니다.'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 애플리케이션을 최대한 유용하고 효율적으로 유지하기 위해 노력하고 있으며, 이에 따라 언제든지 애플리케이션을 수정하거나 서비스에 대한 요금을 부과할 권리를 보유합니다. 단, 애플리케이션이나 서비스에 대한 요금이 발생하는 경우, 서비스 제공자는 이를 명확하게 사용자에게 고지할 것입니다.'),
            const AgreementContents(
                contents:
                    '애플리케이션은 서비스를 제공하기 위해 사용자가 제공한 개인정보를 저장하고 처리합니다. 사용자는 자신의 휴대전화 및 애플리케이션에 대한 접근 보안을 유지할 책임이 있습니다. 서비스 제공자는 사용자의 기기에서 소프트웨어 제한 및 보안 기능을 제거하는 **탈옥(jailbreaking) 또는 루팅(rooting)**을 강력히 권장하지 않습니다. 이러한 행위는 기기를 악성 코드, 바이러스 및 보안 위협에 노출시키고, 애플리케이션이 정상적으로 작동하지 않을 가능성이 있습니다.'),
            const AgreementContents(
                contents:
                    '애플리케이션은 자체적으로 운영되는 것이 아니라 일부 제3자 서비스를 이용합니다. 이러한 제3자 서비스에는 자체적인 이용 약관이 적용되므로, 아래 링크를 참고하시기 바랍니다:'),
            const LaunchUrlTextButton(
              url: 'https://policies.google.com/terms',
              text: "Google Play 서비스",
            ),
            const LaunchUrlTextButton(
              url: 'https://developers.google.com/admob/terms',
              text: "AdMob",
            ),
            const AgreementTitle(title: '책임 제한'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 특정 사항에 대한 책임을 지지 않습니다. 예를 들어, 애플리케이션의 일부 기능은 Wi-Fi 또는 모바일 네트워크를 통한 인터넷 연결이 필요합니다. 사용자의 데이터 요금 초과나 인터넷 연결 불가로 인해 애플리케이션이 정상적으로 작동하지 않는 경우, 서비스 제공자는 이에 대한 책임을 지지 않습니다.'),
            const AgreementContents(
                contents:
                    'Wi-Fi가 아닌 환경에서 애플리케이션을 사용할 경우, 사용자의 모바일 네트워크 제공업체의 요금 정책이 적용됩니다. 따라서 사용자는 애플리케이션을 사용할 때 발생하는 모든 데이터 요금(로밍 요금 포함)에 대한 책임을 져야 합니다. 또한, 사용자가 기기 요금제의 청구자가 아닐 경우, 청구자로부터 사용 허가를 받았다고 간주됩니다.'),
            const AgreementContents(
                contents:
                    '사용자가 애플리케이션을 이용하는 과정에서 발생하는 일부 상황에 대해서도 서비스 제공자는 책임을 지지 않습니다. 예를 들어, 사용자의 기기가 충전되지 않아 서비스에 접근할 수 없는 경우, 이는 사용자의 책임입니다.'),
            const AgreementContents(
                contents:
                    '애플리케이션의 정보 정확성을 유지하기 위해 노력하고 있지만, 서비스 제공자는 일부 정보를 제3자로부터 제공받아 사용자에게 제공하므로, 해당 정보의 정확성이나 신뢰성에 대해 보장할 수 없습니다. 따라서 애플리케이션의 기능을 전적으로 신뢰하여 발생한 손해에 대해 서비스 제공자는 책임을 지지 않습니다.'),
            const AgreementTitle(title: '애플리케이션 업데이트 및 종료'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 애플리케이션을 필요에 따라 업데이트할 수 있습니다. 운영 체제 요구 사항이 변경될 경우, 사용자는 지속적인 애플리케이션 사용을 위해 업데이트를 다운로드해야 할 수 있습니다. 단, 서비스 제공자는 애플리케이션이 항상 최신 운영 체제와 호환됨을 보장하지 않습니다. 사용자는 제공된 업데이트를 수락하고 적용할 것에 동의합니다.'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 언제든지 애플리케이션 제공을 중단할 수 있으며, 사전 공지 없이 사용자의 애플리케이션 이용을 종료할 권리를 가집니다. 애플리케이션이 종료되는 경우, (a) 본 이용 약관에서 부여된 권리와 라이선스는 종료되며, (b) 사용자는 애플리케이션 사용을 중단하고 필요 시 기기에서 삭제해야 합니다.'),
            const AgreementTitle(title: '이용 약관 변경 사항'),
            const AgreementContents(
                contents:
                    '서비스 제공자는 필요에 따라 본 이용 약관을 업데이트할 수 있습니다. 따라서 사용자는 정기적으로 본 페이지를 검토하는 것이 좋습니다. 서비스 제공자는 새로운 이용 약관을 본 페이지에 게시함으로써 변경 사항을 공지할 것입니다.'),
            const AgreementContents(
                contents: '본 이용 약관은 2024년 12월 30일부터 유효합니다.'),
            const AgreementTitle(title: '문의하기'),
            const AgreementContents(
                contents:
                    '본 이용 약관에 대한 질문이나 제안이 있는 경우, kjp00552277@gmail.com으로 서비스 제공자에게 연락해 주시기 바랍니다.'),
            const AgreementContents(
                contents:
                    '본 이용 약관 페이지는 App Privacy Policy Generator를 이용하여 생성되었습니다.'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () async {
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
                    },
                    child:
                        Text(_isLoading ? "게임 시작..." : "위 내용을 확인 및 동의합니다 2/2"),
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
