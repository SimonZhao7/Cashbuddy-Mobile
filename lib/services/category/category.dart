// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
// Constants
import 'fields.dart';

class Category {
  final String id;
  final String userId;
  final String title;

  Category({required this.id, required this.userId, required this.title});
  
  factory Category.fromFirebase(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Category(
      id: snapshot.id,
      userId: data[userIdField],
      title: data[titleField],
    );
  }
}
