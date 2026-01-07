class PhoneCountryData {
  final String phoneCode;
  final String flagEmoji;

  const PhoneCountryData({required this.phoneCode, required this.flagEmoji});

  static const defaultCountryData = PhoneCountryData(
    phoneCode: "62",
    flagEmoji: "🇮🇩",
  );
}

enum LoginState {
  initial,
  loading,
  timeout,
  codeSent,
  verifying,
  success,
  error,
}

class LoginStateData {
  final LoginState status;
  final String? errorMessage;
  final String? verificationId;
  final int? resendCode;
  final PhoneCountryData countryPhoneId;
  final String numberPhone;
  final String redirectPath;

  LoginStateData({
    this.status = LoginState.initial,
    this.errorMessage,
    this.verificationId,
    this.resendCode,
    this.countryPhoneId = PhoneCountryData.defaultCountryData,
    this.numberPhone = '',
    this.redirectPath = 'otp-screen',
  });

  LoginStateData copyWith({
    LoginState? status,
    String? errorMessage,
    String? verificationId,
    int? resendCode,
    PhoneCountryData? countryPhoneId,
    String? numberPhone,
    String? redirectPath,
  }) {
    return LoginStateData(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      verificationId: verificationId ?? this.verificationId,
      resendCode: resendCode ?? this.resendCode,
      countryPhoneId: countryPhoneId ?? this.countryPhoneId,
      numberPhone: numberPhone ?? this.numberPhone,
      redirectPath: redirectPath ?? this.redirectPath,
    );
  }
}
