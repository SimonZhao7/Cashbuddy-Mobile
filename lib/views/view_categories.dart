import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';
// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewCategories extends StatefulWidget {
  const ViewCategories({super.key});

  @override
  State<ViewCategories> createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> categories;

  @override
  void initState() {
    final db = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final query =
        db.collection('categories').where('user_id', isEqualTo: userId);

    categories = query.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: categories,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                final title = snapshot.data!.docs[index].data()['title'] as String;
                final id = snapshot.data!.docs[index].id;
                return ListTile(
                  title: Text(title),
                  tileColor: const Color(white),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        navigator.pushNamed(
                          createOrUpdateCategoryRoute,
                          arguments: [id, title],
                        );
                      },
                    ),
                    const Gap(10),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ]),
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(20);
              },
            );
          default:
            return const Center(
              child: CircularProgressIndicator(
                color: Color(darkGreen),
              ),
            );
        }
      },
    );
  }
}
