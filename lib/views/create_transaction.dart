import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
// Services
import '../services/category/category_service.dart';
import 'package:cashbuddy_mobile/services/auth/auth_service.dart';
// Widgets
import '../widgets/button.dart';
import 'package:cashbuddy_mobile/widgets/input.dart';
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  late TextEditingController _title;
  late TextEditingController _details;
  late TextEditingController _amount;
  late CategoryService _categoryService;
  String? _selected;
  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    _title = TextEditingController();
    _details = TextEditingController();
    _amount = TextEditingController();
    _categoryService = CategoryService();
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Create Transaction'),
      ),
      body: FutureBuilder(
        future: _categoryService.fetchCategories().first,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 60,
                horizontal: 30,
              ),
              children: [
                const Text('Category', style: textStyle),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(white),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: data
                          .map(
                            (category) => DropdownMenuItem(
                              value: category.title,
                              child: Text(category.title),
                            ),
                          )
                          .toList(),
                      isExpanded: true,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      value: _selected,
                      hint: const Text('Please select a category'),
                      onChanged: (item) {
                        setState(() {
                          _selected = item!;
                        });
                      },
                    ),
                  ),
                ),
                const Gap(20),
                const Text('Title', style: textStyle),
                const Gap(10),
                Input(controller: _title),
                const Gap(20),
                const Text('Details', style: textStyle),
                const Gap(10),
                Input(
                  controller: _details,
                  type: TextInputType.multiline,
                  maxLines: 6,
                ),
                const Gap(20),
                const Text('Amount', style: textStyle),
                const Gap(10),
                Input(controller: _amount, type: TextInputType.number),
                const Gap(20),
                const Text('Date', style: textStyle),
                const Gap(10),
                Button(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.parse('2000-01-01'),
                      lastDate: DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.input,
                    );
                    setState(() {
                      date = selectedDate;
                    });
                  },
                  label: date == null
                      ? 'Select Date'
                      : DateFormat.yMd().format(date!),
                ),
                const Gap(20),
                const Text('Time', style: textStyle),
                const Gap(10),
                Button(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input,
                    );
                    setState(() {
                      time = selectedTime;
                    });
                  },
                  label: time == null ? 'Select Time' : time!.format(context),
                ),
                const Gap(20),
                Button(
                  onPressed: () async {
                    try {
                      final db = FirebaseFirestore.instance;
                      final user = AuthService.email().currentUser;
                      final navigator = Navigator.of(context);

                      final title = _title.text;
                      final details = _details.text;
                      final amount = double.tryParse(_amount.text);
                      final selectedDate = date;
                      final selectedTime = time;
                      final selectedCategory = _selected;

                      if (selectedCategory == null) {
                        return showErrorSnackBar(
                          context: context,
                          text: 'No category selected',
                        );
                      }

                      if (title.trim().isEmpty) {
                        return showErrorSnackBar(
                          context: context,
                          text: 'No title provided',
                        );
                      }

                      if (amount == null) {
                        return showErrorSnackBar(
                          context: context,
                          text: 'Invalid amount provided',
                        );
                      }

                      if (selectedDate == null) {
                        return showErrorSnackBar(
                          context: context,
                          text: 'No date selected',
                        );
                      }

                      if (selectedTime == null) {
                        return showErrorSnackBar(
                          context: context,
                          text: 'No time selected',
                        );
                      }

                      final categoryId = data
                          .firstWhere(
                            (category) => category.title == selectedCategory,
                          )
                          .id;

                      final dateTime = selectedDate.add(
                        Duration(
                          hours: selectedTime.hour,
                          minutes: selectedTime.minute,
                        ),
                      );

                      await db.collection('transactions').add({
                        'user_id': user.id,
                        'category_id': categoryId,
                        'title': title,
                        'details': details,
                        'amount': amount,
                        'date_time': dateTime,
                      });

                      navigator.pop();
                    } catch (e) {
                      showErrorSnackBar(
                        context: context,
                        text: 'Could not create a transaction',
                      );
                    }
                  },
                  label: 'Create Transaction',
                  backgroundColor: darkGreen,
                  textColor: white,
                ),
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
