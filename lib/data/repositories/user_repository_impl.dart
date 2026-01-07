import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rechap/data/model/user_model.dart';
import 'package:rechap/domain/common/result.dart';
import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore firebaseFirestore;

  UserRepositoryImpl({required this.firebaseFirestore});

  @override
  Future<Result<void>> createUser(UserEntity data) async {
    try {
      final userModel = UserModel.fromEntity(data);

      await firebaseFirestore
          .collection('users')
          .doc(data.uid)
          .set(userModel.toFirestore());

      return Result.success(null);
    } on FirebaseException catch (e) {
      return Result.error("Firebase Exception: ${e.message}");
    } catch (e) {
      return Result.error("Failed to save user: $e");
    }
  }

  @override
  Future<Result<UserEntity>> getPhoneNumberAvailable(String data) async {
    try {
      final usersCollection = firebaseFirestore.collection('users');

      final queryUsers = await usersCollection
          .where('phone_number', isEqualTo: data)
          .get();

      if (queryUsers.docs.isNotEmpty) {
        return Result.success(
          UserEntity(uid: queryUsers.docs.first.id, phoneNumber: data),
        );
      }

      return Result.error("Phone number is not available");
    } catch (e) {
      return Result.error("Failed to get user: $e");
    }
  }
}
