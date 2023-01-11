import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/services/auth/auth_service.dart';
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:cashbuddy_mobile/widgets/input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  late TextEditingController _category;

  @override
  void initState() {
    _category = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>?;
    final id = args?[0];
    final title = args?[1];
    _category.text = title ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          id == null ? 'Create a new category' : 'Update category',
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Category Name', style: TextStyle(fontSize: 16)),
            const Gap(10),
            Input(
              controller: _category,
              autofocus: true,
            ),
            const Gap(20),
            Button(
              onPressed: () async {
                final db = FirebaseFirestore.instance;
                final user = AuthService.email().currentUser;
                final navigator = Navigator.of(context);
                final categoryName = _category.text;

                if (categoryName.trim().isEmpty) {
                  showErrorSnackBar(
                    context: context,
                    text: 'No title provided',
                  );
                  return;
                }

                if (id != null) {
                  await db.collection('categories').doc(id).update({
                    'title': categoryName,
                  });
                } else {
                  await db.collection('categories').add({
                    'title': categoryName,
                    'user_id': user.id,
                  });
                }

                navigator.pop();
              },
              label: id == null ? 'Create' : 'Update',
              backgroundColor: darkGreen,
              textColor: white,
            )
          ],
        ),
      ),
    );
  }
}
