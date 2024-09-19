// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/DataBase/Model/task.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/Providers/locale_provider.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/Utility/date_utils.dart';
import 'package:to_do/UI/Utility/dialog_utils.dart';
import 'package:to_do/UI/common/date_time_field.dart';
import 'package:to_do/UI/common/material_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
    LocaleProvider localeProvider = Provider.of<LocaleProvider>(context);
    return Container(
      padding: const EdgeInsets.all(14),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MaterialTextFormField(
              hint: AppLocalizations.of(context)!.add_task,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return AppLocalizations.of(context)!.title_empty;
                }
                return null;
              },
              controller: titleController,
              readOnly: false,
            ),
            MaterialTextFormField(
              hint: AppLocalizations.of(context)!.description,
              maxTextLines: 3,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return AppLocalizations.of(context)!.description_empty;
                }
                return null;
              },
              controller: descriptionController,
              readOnly: false,
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                    child: TimeField(
                  title: AppLocalizations.of(context)!.task_date,
                  hint: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : "${selectedDate?.formatDate()}",
                  onClick: () {
                    showDatePickerDialog();
                  },
                )),
                Expanded(
                    child: TimeField(
                  title: AppLocalizations.of(context)!.task_time,
                  hint: selectedTime == null
                      ? AppLocalizations.of(context)!.select_time
                      : "${selectedTime?.formatTime()}",
                  onClick: () {
                    showTimePickerDialog();
                  },
                )),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.add_task,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }

  DateTime? selectedDate;

  void showDatePickerDialog() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;
    setState(() {
      selectedDate = date;
    });
  }

  TimeOfDay? selectedTime;

  void showTimePickerDialog() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      selectedTime = time;
    });
  }

  bool isValidTask() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (selectedTime == null) {
      showMessageDialog(context,
          message: AppLocalizations.of(context)!.select_time, posButtonTitle: AppLocalizations.of(context)!.yes);
      isValid = false;
    }
    if (selectedDate == null) {
      showMessageDialog(context,
          message: AppLocalizations.of(context)!.choose_date, posButtonTitle: AppLocalizations.of(context)!.yes);
      isValid = false;
    }
    return isValid;
  }

  void addTask() async {
    if (isValidTask() == false) return;

    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
   var tasksProvider = TasksProvider.getInstance(context, listen: false);
    var task = Task(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate!.dateOnly(),
      time: selectedTime!.timeSinceEpoch(),
    );
    try {
      showLoadingDialog(context, message: AppLocalizations.of(context)!.adding_task);
      var result = await  tasksProvider.createTask(
           authProvider.appUser?.authId  ?? "id",task);
      hideLoadingDialog(context);
      showMessageDialog(context, message: AppLocalizations.of(context)!.success_add,
          posButtonAction: () {
        Navigator.pop(context);
      });
    } catch (e) {
      hideLoadingDialog(context);
      showMessageDialog(context, message: AppLocalizations.of(context)!.error, posButtonTitle: AppLocalizations.of(context)!.yes);
    }
  }
}
