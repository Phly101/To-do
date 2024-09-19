import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:to_do/Providers/theme_provider.dart';

class ThemeButtonSheet extends StatefulWidget {
  const ThemeButtonSheet({super.key});

  @override
  State<ThemeButtonSheet> createState() => _ThemeButtonSheetState();
}

class _ThemeButtonSheetState extends State<ThemeButtonSheet> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
            child: Text("Selected Mode: ${isDark ? 'Dark' : 'Light'}", style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary
                )

            ),
          ),

          InkWell(
              onTap: (){
                setState(() {
                  themeProvider.changeTheme(ThemeMode.light);
                });

              },

              child:
              isDark ? getUnSelectedItem(context,'Light',isDark) :
              getSelectedItem(context,'Light',isDark)),
          const Divider(
            height: 24,
          ),
          InkWell(
              onTap: (){
                setState(() {
                  themeProvider.changeTheme(ThemeMode.dark);
                });

              },

              child:
              isDark ? getSelectedItem(context,'Dark',isDark) :
              getUnSelectedItem(context,'Dark',isDark)),
        ],
      ),
    );
  }

  Widget getSelectedItem(BuildContext context,String text,bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary

          )
        ),
        Icon(
          Icons.check_circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget getUnSelectedItem(BuildContext context,String text,bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: isDark? Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,

        ):Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black

        )),
        Icon(
          Icons.radio_button_unchecked_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
