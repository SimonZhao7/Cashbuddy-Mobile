import 'dart:async';
// Exceptions
import 'package:cashbuddy_mobile/exceptions/category_exceptions.dart';
// Category
import 'package:cashbuddy_mobile/services/category/category.dart';
// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/auth_service.dart';
// Constants
import 'fields.dart';

class CategoryService {
  final user = AuthService.email().currentUser;
  final collection = FirebaseFirestore.instance.collection(collectionName);

  static final _shared = CategoryService._sharedInstance();
  CategoryService._sharedInstance();
  factory CategoryService() {
    return _shared;
  }

  Stream<List<Category>> fetchCategories() {
    final snapshots = collection
        .where(
          userIdField,
          isEqualTo: user.id,
        )
        .snapshots();
    return snapshots.map(
      (querySnapshot) => querySnapshot.docs.map(Category.fromFirebase).toList(),
    );
  }

  Future<void> createCategory({required String title}) async {
    if (title.trim().isEmpty) throw NoTitleProvidedException();

    await collection.add({
      titleField: title,
      userIdField: user.id,
    });
  }

  Future<void> updateCategory({
    required String id,
    required String title,
  }) async {
    if (title.trim().isEmpty) throw NoTitleProvidedException();

    await collection.doc(id).update({
      titleField: title,
    });
  }

  Future<void> deleteCategory({required String id}) async {
    await collection.doc(id).delete();
  }
}
