import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/Providers/locale_provider.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/Home/home_screen.dart';
import 'package:to_do/UI/Tabs/Edit_tab/edit_screen.dart';
import 'package:to_do/UI/register/register_screen.dart';
import 'package:to_do/theme/theme.dart';
import 'package:to_do/UI/log_in/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var sharedPreferences = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
        ChangeNotifierProvider(create: (_) => TasksProvider()),
        ChangeNotifierProvider(create: (_)=> ThemeProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(sharedPreferences)),
      ],
       child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LocaleProvider langProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: themeProvider.currentTheme,
      locale: Locale(langProvider.currentLocale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,


      initialRoute: authProvider.isLoggedIn() ? HomeScreen.routeName : LoginScreen.routeName,

      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        EditScreen.routeName: (context) =>  EditScreen(),
      },
    );
  }
}
