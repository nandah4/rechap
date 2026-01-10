import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechap/data/model/user_model.dart';
import 'package:rechap/domain/common/result.dart';
import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  UserRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

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
  Future<Result<void>> updateUser(Map<String, dynamic> field) async {
    try {
      final currentUser = firebaseAuth.currentUser?.uid;

      if (currentUser == null) return Result.error("User not found");

      final profileRef = firebaseFirestore.collection('users').doc(currentUser);

      await profileRef.update({
        ...field,
        'updated_at': FieldValue.serverTimestamp(),
      });

      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
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

  @override
  Future<Result<UserEntity>> getCurrentUser() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) return Result.error("User not logged in!");

      DocumentReference<Map<String, dynamic>> docRef = firebaseFirestore
          .collection('users')
          .doc(currentUser.uid);

      DocumentSnapshot<Map<String, dynamic>> snapshot = await docRef.get();

      if (!snapshot.exists) return Result.error("User not found");

      final userModelResult = UserModel.fromJson(snapshot.data()!);

      return Result.success(userModelResult.toEntity());
    } catch (e) {
      return Result.error("Failed to get user $e");
    }
  }
}
