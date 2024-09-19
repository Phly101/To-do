import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/Tabs/List_Tab/list_tab.dart';
import 'package:to_do/UI/Tabs/Settings/add_task_bottom_sheet.dart';
import 'package:to_do/UI/Tabs/Settings/settings_tab/settings_tab.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDarkEnabled();

    return Scaffold(

      bottomNavigationBar: BottomAppBar(
        color: isDark ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.onPrimary,

        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selectedTabIndex,
          onTap: (newSelectedIndex) {
            selectedTabIndex = newSelectedIndex;
            setState(() {});
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_outlined,
                  size: 40,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 40,
                ),
                label: ""),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const StadiumBorder(
          side: BorderSide(
            width: 4,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          showAddTaskBottomSheet(context);
        },
        child: const SizedBox(

          width: 56,
          height: 56,
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      body: tabs[selectedTabIndex],
    );
  }

  var tabs = [
    const ListTab(),
    const SettingsTab(),
  ];

  void showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (buildContext) {
          return const AddTaskBottomSheet();
        });
  }
}
