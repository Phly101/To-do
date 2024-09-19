import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:to_do/Providers/locale_provider.dart';
import 'package:to_do/Providers/theme_provider.dart';

class LangButtonSheet extends StatefulWidget {
  const LangButtonSheet({super.key});

  @override
  State<LangButtonSheet> createState() => _LangButtonSheetState();
}

class _LangButtonSheetState extends State<LangButtonSheet> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDarkEnabled();
    LocaleProvider langProvider = Provider.of<LocaleProvider>(context);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
            child: Text("Selected Language: ${ langProvider.currentLocale == 'en' ? 'English' : 'German'}", style:
            isDark ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white
            ) :Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black),
            ),
          ),

          InkWell(
              onTap: () {
                setState(() {
                  langProvider.changeLocale('en');

                });
              },
              child:
              langProvider.currentLocale == 'en' ?
              getSelectedItem(context, 'English', isDark)
                  : getUnSelectedItem(context, 'English', isDark)),

          const Divider(
            height: 24,
          ),

          InkWell(
            onTap: () {
              setState(() {
                langProvider.changeLocale('de');
              });
            },
            child:
            langProvider.currentLocale == 'de' ?
            getSelectedItem(context, 'German', isDark)
                : getUnSelectedItem(context, 'German', isDark),
          ),

        ],
      ),
    );
  }

  Widget getSelectedItem(BuildContext context, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:
                 Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary)

          ),
          Icon(
            Icons.check_circle,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget getUnSelectedItem(BuildContext context, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: isDark
                  ? Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white)
                  : Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black)),
          Icon(
            Icons.radio_button_unchecked_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
