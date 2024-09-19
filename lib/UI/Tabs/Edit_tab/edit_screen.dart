import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:to_do/DataBase/Model/task.dart';

import 'package:to_do/Providers/edit_task_provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/Home/home_screen.dart';
import 'package:to_do/UI/Utility/dialog_utils.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = 'edit_screen';

  EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  EditTaskProvider editTaskProvider = EditTaskProvider();

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
    if (editTaskProvider.task == null) {
      var task = ModalRoute
          .of(context)!
          .settings
          .arguments as Task;
      editTaskProvider.initTask(task);
    }

    return ChangeNotifierProvider(
      create: (context) => editTaskProvider,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme
                  .of(context)
                  .primaryColor,
              Theme
                  .of(context)
                  .primaryColor,
              Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              Theme
                  .of(context)
                  .scaffoldBackgroundColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.25, 0.25, 1],
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: Text(
              AppLocalizations.of(context)!.to_do,

              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.edit_task2,
                          style: isDark
                              ? Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Theme
                              .of(context)
                              .primaryColor)
                              : Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Form(
                        key: editTaskProvider.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              controller: editTaskProvider.titleController,
                              validator: (value) =>
                                  editTaskProvider.isValidTask(value ?? " "),
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .edit_title,
                                hintStyle: isDark
                                    ? Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                    color: Theme
                                        .of(context)
                                        .primaryColor)
                                    : Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                            const Divider(
                              color: Colors.transparent,
                              height: 16,
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              controller: editTaskProvider
                                  .descriptionController,
                              validator: (value) =>
                                  editTaskProvider.isValidTask(value ?? " "),
                              decoration: InputDecoration(
                                hintText:
                                AppLocalizations.of(context)!.edit_description,
                                hintStyle: isDark
                                    ? Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                    color: Theme
                                        .of(context)
                                        .primaryColor)
                                    : Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        )),
                    const Divider(
                      color: Colors.transparent,
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.select_time,
                          style: isDark
                              ? Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Theme
                              .of(context)
                              .primaryColor)
                              : Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.black),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        showDatePickerOnScreen();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 16, right: 16),
                          child: Text(
                            DateFormat.yMMMd().format(
                                editTaskProvider.selectedDate),
                            style: isDark
                                ? Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                color: Theme
                                    .of(context)
                                    .primaryColor)
                                : Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.choose_date,
                          style: isDark
                              ? Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Theme
                              .of(context)
                              .primaryColor)
                              : Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        showTimePickerOnScreen();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 16, right: 16),
                          child: Text(
                            editTaskProvider.selectedTime.format(context),
                            style: isDark
                                ? Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                color: Theme
                                    .of(context)
                                    .primaryColor)
                                : Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200.0),
                          ),
                        ),
                        onPressed: () {
                          editTaskProvider.updateTask();
                          Navigator.pushNamed(context, HomeScreen.routeName);

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              AppLocalizations.of(context)!.save_changes,
                              style: isDark
                                  ? Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                  color: Theme
                                      .of(context)
                                      .primaryColor)
                                  : Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white)),
                        )),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDatePickerOnScreen() async {
    var date = await showDatePicker(
      context: context,
      initialDate: editTaskProvider.selectedDate,
      firstDate: editTaskProvider.selectedDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    editTaskProvider.selectedDate = date!;
  }

  void showTimePickerOnScreen() async {
    var time = await showTimePicker(
      context: context,
      initialTime: editTaskProvider.selectedTime,

    );
    editTaskProvider.selectedTime = time!;
  }
}
