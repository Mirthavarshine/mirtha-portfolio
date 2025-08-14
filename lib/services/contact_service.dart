import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'contactMessages';

  static Future<bool> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await _firestore.collection(_collectionName).add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'new',
      });
      return true;
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }

  static Stream<QuerySnapshot> getMessages() {
    return _firestore
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
} 