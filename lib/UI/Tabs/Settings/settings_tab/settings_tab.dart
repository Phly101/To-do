import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/locale_provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/Tabs/Settings/settings_tab/locale_button_sheet.dart';
import 'package:to_do/UI/Tabs/Settings/settings_tab/theme_button_sheet.dart';
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
    LocaleProvider localeProvider = Provider.of<LocaleProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 30.0, left: 30.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.settings,
                  style: isDark? Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,

                  )
                      :Theme.of(context).textTheme.titleLarge
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                  color: Colors.transparent,
                  height: MediaQuery.sizeOf(context).height * 0.02),
              Text(

                AppLocalizations.of(context)!.theme_mode,
                style: isDark? Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                )
                    :Theme.of(context).textTheme.titleMedium,
              ),
              Divider(
                  color: Colors.transparent,
                  height: MediaQuery.sizeOf(context).height * 0.02),
              InkWell(
                onTap: () {
                     showThemeButtonSheet(context);
                },
                child: Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      color: isDark? Theme.of(context).colorScheme.onSecondary:Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text(
                      isDark
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    )),
              ),
              Divider(
                  color: Colors.transparent,
                  height: MediaQuery.sizeOf(context).height * 0.02),
              Text(   AppLocalizations.of(context)!.language,
                style: isDark?   Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                )
                      : Theme.of(context).textTheme.titleMedium,

              ),
              Divider(
                  color: Colors.transparent,
                  height: MediaQuery.sizeOf(context).height * 0.02),
              InkWell(
                onTap: () {
                    showLangButtonSheet(context);
                },
                child: Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        color: isDark? Theme.of(context).colorScheme.onSecondary:Theme.of(context).colorScheme.onPrimary,

                    ),
                    child: Text(
                      localeProvider.currentLocale == 'en'?
                      AppLocalizations.of(context)!.english
                          :AppLocalizations.of(context)!.german
                      ,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )),
              ),
            ],
          ),
        )

      ],
    );
  }
  void showThemeButtonSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ThemeButtonSheet();
        });
  }

  void showLangButtonSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const LangButtonSheet();
        });
  }

}
