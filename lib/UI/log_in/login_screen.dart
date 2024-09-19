import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/UI/Home/home_screen.dart';
import 'package:to_do/UI/Utility/dialog_utils.dart';
import 'package:to_do/UI/Utility/email_validation.dart';
import 'package:to_do/UI/Utility/password_validation.dart';
import 'package:to_do/UI/common/text_forms.dart';
import 'package:to_do/UI/register/register_screen.dart';
import 'package:to_do/fireBaseAuth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5D9CEC),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff5D9CEC),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/images/App_Assets/Route_logo.png",
                      width: double.infinity,
                    ),
                  ),
                ),
                TextForms(
                  title: AppLocalizations.of(context)!.email_address,
                  hint: AppLocalizations.of(context)!.input_email,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return AppLocalizations.of(context)!.input_email;
                    }
                    if (!EmailValidation.isEmailValid(text!)) {
                      return AppLocalizations.of(context)!.invalid_email;
                    }
                    return null;
                  },
                ),
                TextForms(
                  title: AppLocalizations.of(context)!.password,
                  hint: AppLocalizations.of(context)!.input_password,
                  keyboardType: TextInputType.name,
                  securePassword: true,
                  controller: passwordController,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return  AppLocalizations.of(context)!.input_password;
                    }
                    final Pair result = isValidPassword(text!);

                    if (!result.first && result.second == 1) {
                      return AppLocalizations.of(context)!.password6;
                    }
                    if (!result.first && result.second == 2) {
                      return AppLocalizations.of(context)!.password20;
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xff004182),
                          ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dont_have_account,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.sign_up,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    formKey.currentState?.validate();

    signIn();
  }

  void signIn() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    try {
      showLoadingDialog(context, message:AppLocalizations.of(context)!.please_wait);
      final appUser = await authProvider.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      hideLoadingDialog(context);

      if (appUser == null) {
        showMessageDialog(context,
            message: AppLocalizations.of(context)!.user_not_found,
            posButtonTitle: AppLocalizations.of(context)!.try_again, posButtonAction: () {
          signIn();
        });
        return;
      }

      showMessageDialog(context,
          message: AppLocalizations.of(context)!.success_login,
          posButtonTitle: AppLocalizations.of(context)!.yes, posButtonAction: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      String message = AppLocalizations.of(context)!.error;
      if (e.code == FireBaseAuthCodes.UserNotFound ||
          e.code == FireBaseAuthCodes.WrongPassword ||
          e.code == FireBaseAuthCodes.Invalid_Credential) {
        message = AppLocalizations.of(context)!.invalid_password_or_email;
      }

      hideLoadingDialog(context);
      showMessageDialog(context, message: message, posButtonTitle: AppLocalizations.of(context)!.yes);
    } catch (e) {
      String message = AppLocalizations.of(context)!.error;
      hideLoadingDialog(context);
      showMessageDialog(context, message: message, posButtonTitle: AppLocalizations.of(context)!.try_again,
          posButtonAction: () {
        login();
      });
    }
  }
}