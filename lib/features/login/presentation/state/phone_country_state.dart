class PhoneCountryData {
  final String phoneCode;
  final String flagEmoji;

  const PhoneCountryData({required this.phoneCode, required this.flagEmoji});

  static const defaultCountryData = PhoneCountryData(
    phoneCode: "62",
    flagEmoji: "🇮🇩",
  );
}
