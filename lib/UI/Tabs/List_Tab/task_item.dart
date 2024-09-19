import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/DataBase/Model/task.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/Tabs/Edit_tab/edit_screen.dart';
import 'package:to_do/UI/Utility/date_utils.dart';
import 'package:to_do/UI/Utility/dialog_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef OnTaskDeleteClick = void Function(Task task);

class TaskItem extends StatelessWidget {
  Task task;
  OnTaskDeleteClick onTaskDeleteClick;


  TaskItem({
    super.key,
    required this.task,
    required this.onTaskDeleteClick,
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
  AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: (buildContext) {
              showMessageDialog(
                context,
                message: AppLocalizations.of(context)!.delete_task_message,
                posButtonTitle: AppLocalizations.of(context)!.confirm,
                posButtonAction: () {
                  onTaskDeleteClick(task);
                },
                negButtonTitle: AppLocalizations.of(context)!.cancel,
              );
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: AppLocalizations.of(context)!.delete_task,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
          ),
          SlidableAction(
            onPressed: (_) {
              Navigator.pushNamed(context, EditScreen.routeName, arguments: task);
            },
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            label: AppLocalizations.of(context)!.edit_task,
          ),
        ]),
        child: InkWell(
          onDoubleTap: () {
            Provider.of<TasksProvider>(context, listen: false).isTaskToggled(authProvider.authUser?.uid ?? "uid", task);
          },
          child: Consumer<TasksProvider>(
            builder: (context, tasksProvider, child) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: isDark
                    ? Theme.of(context).colorScheme.onSecondary
                    : Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: task.isToggled ?? false
                              ? const Color(0xff61E757)  // Toggled color
                              : const Color(0xff5D9CEC),  // Default color
                        ),
                        width: 4,
                        height: 64,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title ?? '',
                            style: isDark
                                ? Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: task.isToggled ?? false
                                    ? const Color(0xff61E757)  // Toggled text color
                                    : const Color(0xff5D9CEC))  // Default text color
                                : Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: task.isToggled ?? false
                                    ? const Color(0xff61E757)  // Toggled text color
                                    : const Color(0xff000000)),  // Default text color
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: isDark
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.black,
                              ),
                              Text(
                                "${task.time?.formatTime()}",
                                style: isDark
                                    ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary)
                                    : Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child:task.isToggled ?? false
                          ?
                           Text(
                        AppLocalizations.of(context)!.task_done,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary),
                      ):Container(
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 14.0, right: 14.0),
                          child: ImageIcon(
                            AssetImage("assets/icons/icon_check2.png"),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      )
                    ),
                  ],
                ),

              );
            },
          ),
        ),
      ),
    );
  }
}
