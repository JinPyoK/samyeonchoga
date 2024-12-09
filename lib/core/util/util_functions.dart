/// 파이어베이스 리얼타임 데이터베이스의 경로에는 공백, 특수문자 등이 들어갈 수 없다
String makeRankId() {
  String dateTimeString = DateTime.now().toLocal().toString();

  /// 숫자만 추출
  String onlyNumbers = dateTimeString.replaceAll(RegExp(r'[^0-9]'), '');

  return onlyNumbers;
}
