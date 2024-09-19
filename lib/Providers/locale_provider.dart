import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LocaleProvider extends ChangeNotifier {
  String currentLocale =  "en";
  static const String localeKey ="lang";
  final SharedPreferences prefs;

  LocaleProvider(this.prefs){
    readSavedLocale();
  }
  void readSavedLocale() async {

    currentLocale = prefs.getString(localeKey) ?? "en";
  }

  void saveLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(localeKey, currentLocale);
  }



  void changeLocale(String newLocale) {
    currentLocale = newLocale;
    notifyListeners();
    saveLocale();

  }
  }