// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/DataBase/Model/task.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/Tabs/List_Tab/task_item.dart';
import 'package:to_do/UI/Utility/date_utils.dart';
import 'package:to_do/UI/Utility/dialog_utils.dart';
import 'package:to_do/UI/log_in/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<Task>? tasksList;
  late TasksProvider tasksProvider;
  late AppAuthProvider authProvider;

  @override
  void initState() {
    authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    super.initState();
  }

  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDarkEnabled();
    var provider = Provider.of<AppAuthProvider>(context);
    tasksProvider = TasksProvider.getInstance(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Stack(
            children: [
              Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 30.0, left: 30.0, right: 20.0),
                        child: Text(
                          AppLocalizations.of(context)!.to_do,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showMessageDialog(context,
                                message: AppLocalizations.of(context)!
                                    .logout_message,
                                posButtonTitle:
                                    AppLocalizations.of(context)!.yes,
                                negButtonTitle: AppLocalizations.of(context)!
                                    .no, posButtonAction: () {
                              provider.logout();
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            });
                          },
                          child:  Icon(
                            Icons.logout,
                            color: isDark? Theme.of(context).colorScheme.onSecondary:Colors.white,
                          )),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 155.0),
                child: EasyDateTimeLine(
                  initialDate: selectedDate,
                  onDateChange: (clickedDate) {
                    setState(() {
                      selectedDate = clickedDate;
                    });
                  },

                  // activeColor:  Colors.white,

                  headerProps: const EasyHeaderProps(showHeader: false),
                  activeColor: Theme.of(context).primaryColor,
                  dayProps: EasyDayProps(
                      todayStyle: DayStyle(
                          dayStrStyle: isDark
                              ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary)
                              : Theme.of(context).textTheme.bodyMedium,
                          dayNumStyle: isDark
                              ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary)
                              : Theme.of(context).textTheme.bodyMedium,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: isDark
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.primary,
                          )),
                      activeDayStyle: DayStyle(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isDark
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.primary)),
                      inactiveDayStyle: DayStyle(

                          dayNumStyle: isDark
                              ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary)
                              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isDark
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Colors.white))),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
              stream: tasksProvider.tasksCollection.listenForTasks(
                  authProvider.authUser?.uid ?? "#todo",
                  selectedDate.dateOnly()),
              builder: (buildContext, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.error),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child:
                                Text(AppLocalizations.of(context)!.try_again))
                      ],
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var tasksList = snapshot.data?.docs
                    .map((docSnapshot) => docSnapshot.data())
                    .toList();
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: tasksList![index],
                      onTaskDeleteClick: deleteTask,
                      // onTaskUpdateClick: updateTask,
                    );
                  },
                  separatorBuilder: (_, __) {
                    return Container(
                      height: 24,
                    );
                  },
                  itemCount: tasksList?.length ?? 0,
                );
              }),
        ),

        /*FutureBuilder<List<Task>>(

            future: tasksProvider.getAllTasks(authProvider.authUser?.uid ?? "#todo", selectedDate),
            builder: (buildContext, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      const Text("Something went wrong"),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text("Retry"))
                    ],
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var tasksList = snapshot.data;
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: tasksList![index],
                      onTaskDeleteClick: deleteTask,
                    );
                  },
                  separatorBuilder: (_, __) {
                    return Container(
                      height: 24,
                    );
                  },
                  itemCount: tasksList?.length ?? 0,
                ),
              );
            }),*/
      ],
    );
  }

  void deleteTask(Task task) async {
    showLoadingDialog(context,
        message: AppLocalizations.of(context)!.deleting_task);
    try {
      await tasksProvider.removeTasks(
          authProvider.authUser?.uid ?? "#todo", task);
      hideLoadingDialog(context);
    } catch (e) {
      showMessageDialog(context,
          message: e.toString(),
          posButtonTitle: AppLocalizations.of(context)!.try_again,
          posButtonAction: () {
        deleteTask(task);
      });
    }
  }
}
