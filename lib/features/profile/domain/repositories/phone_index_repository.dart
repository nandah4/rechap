import 'package:rechap/features/profile/domain/entities/phone_index.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/profile/data/models/phone_index_model.dart';

abstract class PhoneIndexRepository {
  Future<Result<void>> createPhoneIndex(PhoneIndexEntity data);
  Future<Result<PhoneIndexModel>> checkPhoneNumberAvailable(String data);
}
