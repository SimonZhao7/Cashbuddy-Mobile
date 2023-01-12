import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Services
import '../services/category/category_service.dart';
// Widgets
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:cashbuddy_mobile/widgets/input.dart';
// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';
// Exceptions
import 'package:cashbuddy_mobile/exceptions/category_exceptions.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  late TextEditingController _category;
  late CategoryService _categoryService;

  @override
  void initState() {
    _category = TextEditingController();
    _categoryService = CategoryService();
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
                try {
                  final navigator = Navigator.of(context);
                  final categoryName = _category.text;

                  if (id != null) {
                    await _categoryService.updateCategory(
                      id: id,
                      title: categoryName,
                    );
                  } else {
                    await _categoryService.createCategory(
                      title: categoryName,
                    );
                  }
                  navigator.pop();
                } catch (e) {
                  if (e is NoTitleProvidedException) {
                    showErrorSnackBar(
                      context: context,
                      text: 'No title provided',
                    );
                  }
                }
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
