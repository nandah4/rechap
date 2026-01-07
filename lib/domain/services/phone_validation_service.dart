class PhoneValidationService {
  /// Method _validatePhoneNumber to validate input from controller
  String? validatePhoneNumber(String numberPhone) {
    if (numberPhone.isEmpty) {
      return "Phone number is required";
    }
    if (numberPhone.length < 8) {
      return "Phone number min 8 characters";
    }
    if (numberPhone.length > 14) {
      return "Phone number max 14 characters";
    }

    final patternPhoneNumber = RegExp(r'^[0-9]+$');
    if (!patternPhoneNumber.hasMatch(numberPhone)) {
      return "Phone number is invalid format";
    }

    return null;
  }

  /// Format phone number with country code

  String formatPhoneNumberCountry(String countryCode, String numberPhone) {
    return "+$countryCode$numberPhone";
  }
}
