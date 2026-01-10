import 'package:rechap/features/profile/domain/entities/phone_index.dart';
import 'package:rechap/features/profile/data/models/phone_index_model.dart';
import 'package:rechap/features/profile/domain/repositories/phone_index_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/profile/data/mapper/user_mapper.dart';

class PhoneIndexRepositoryImpl extends PhoneIndexRepository {
  final FirebaseFirestore _firebaseFirestore;

  PhoneIndexRepositoryImpl({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  @override
  Future<Result<void>> createPhoneIndex(PhoneIndexEntity data) async {
    try {
      final phoneIdxToModel = data.toModel();

      await _firebaseFirestore
          .collection('phone_index')
          .add(phoneIdxToModel.toJson());

      return Result.success(null);
    } catch (e) {
      return Result.error("Unknown Error ${e.toString()}");
    }
  }

  @override
  Future<Result<PhoneIndexModel>> checkPhoneNumberAvailable(
    String phoneNumber,
  ) async {
    try {
      final docsPhone = await _firebaseFirestore
          .collection('phone_index')
          .where('phone_number', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (docsPhone.docs.isNotEmpty) {
        final docsSnapshot = docsPhone.docs.first;
        return Result.success(PhoneIndexModel.fromJson(docsSnapshot.data()));
      }

      return Result.error("Number Not Found");
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
