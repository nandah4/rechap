import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechap/features/profile/data/mapper/user_mapper.dart';
import 'package:rechap/features/profile/data/models/user_model.dart';
import 'package:rechap/features/profile/domain/entities/user_entity.dart';
import 'package:rechap/features/profile/domain/repositories/user_repository.dart';
import 'package:rechap/core/common/result.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  UserRepositoryImpl({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
  }) : _firebaseFirestore = firebaseFirestore,
       _firebaseAuth = firebaseAuth;

  @override
  Future<Result<void>> createUser(UserEntity entity) async {
    try {
      final userModel = entity.toModel();

      await _firebaseFirestore.collection('users').doc(userModel.uid).set({
        ...userModel.toFirestore(),
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

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
      final currentUser = _firebaseAuth.currentUser?.uid;

      if (currentUser == null) return Result.error("User not found");

      final profileRef = _firebaseFirestore
          .collection('users')
          .doc(currentUser);

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
  Future<Result<UserEntity>> getCurrentUser() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) return Result.error("User not logged in!");

      DocumentReference<Map<String, dynamic>> docRef = _firebaseFirestore
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

  @override
  Future<Result<void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
