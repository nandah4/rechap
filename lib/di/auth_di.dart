import 'package:rechap/data/providers/firebase_providers.dart';
import 'package:rechap/domain/services/phone_auth_service.dart';
import 'package:rechap/domain/services/phone_validation_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneValidationServiceProvider = Provider<PhoneValidationService>(
  (red) => PhoneValidationService(),
);

final phoneAuthServiceProvider = Provider<PhoneAuthService>(
  (ref) => PhoneAuthService(ref.read(firebaseAuthProvider)),
);
