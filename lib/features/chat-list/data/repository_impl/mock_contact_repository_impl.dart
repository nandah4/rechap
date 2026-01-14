import 'package:rechap/features/chat-list/domain/repositories/contact_repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as flutter_contacts;
import 'package:rechap/features/chat-list/data/models/contact_model.dart';
import 'dart:typed_data';

class MockContactRepositoryImpl implements ContactRepository {
  @override
  Future<List<Contact>> fetchContacts() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      List<Contact> contacts = [
        Contact(
          id: "1234567",
          displayName: "Ananda Priya Yustira 2",
          phoneNumber: ['+6282213531164'],
          photo: Uint8List(0),
        ),
        Contact(
          id: "1234568",
          displayName: "Dosen Wali",
          phoneNumber: ['+628123456789'],
          photo: Uint8List(0),
        ),
        Contact(
          id: "1234569",
          displayName: "Teman Kelas",
          phoneNumber: ['+628198765432'],
          photo: Uint8List(0),
        ),
        Contact(
          id: "1234569",
          displayName: "Teman Kuliah",
          phoneNumber: ['+628198765432'],
          photo: Uint8List(0),
        ),
        Contact(
          id: "1234569",
          displayName: "Teman Kerja",
          phoneNumber: ['+628198765432'],
          photo: Uint8List(0),
        ),
        Contact(
          id: "1234570",
          displayName: "Admin Kampus",
          phoneNumber: ['+62341123456'],
          // Contoh jika foto kosong (pastikan UI handle null/empty)
          photo: Uint8List(0),
        ),
      ];

      return contacts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> requestContactPermission() async {
    await flutter_contacts.FlutterContacts.requestPermission();
  }
}
