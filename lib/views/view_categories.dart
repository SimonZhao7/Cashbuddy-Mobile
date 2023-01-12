import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:gap/gap.dart';
// Services
import 'package:cashbuddy_mobile/services/category/category_service.dart';
import '../services/category/category.dart';
// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/constants/routes.dart';

class ViewCategories extends StatefulWidget {
  const ViewCategories({super.key});

  @override
  State<ViewCategories> createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  late CategoryService _categoryService;
  late Stream<List<Category>> _categories;

  @override
  void initState() {
    _categoryService = CategoryService();
    _categories = _categoryService.fetchCategories();
    super.initState();
  }

  Future<bool> showNativeDialog(BuildContext context) async {
    final navigator = Navigator.of(context);

    if (defaultTargetPlatform == TargetPlatform.android) {
      return await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: ((context) {
              return AlertDialog(
                title: const Text('Delete Category'),
                content: const Text(
                    'Are you sure you want to delete this category?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      navigator.pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      navigator.pop(true);
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            }),
          ) ??
          false;
    } else {
      return await showCupertinoDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: ((context) {
              return CupertinoAlertDialog(
                title: const Text('Delete Category'),
                content: const Text(
                    'Are you sure you want to delete this category?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      navigator.pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      navigator.pop(true);
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            }),
          ) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return StreamBuilder<List<Category>>(
      stream: _categories,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            final data = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final title = data[index].title;
                final id = data[index].id;
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
                      onPressed: () async {
                        final result = await showNativeDialog(context);
                        if (result) {
                          await _categoryService.deleteCategory(id: id);
                        }
                      },
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
