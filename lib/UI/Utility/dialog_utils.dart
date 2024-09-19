import 'package:flutter/material.dart';

void showMessageDialog(BuildContext context,
    {required String message,
    String? posButtonTitle,
    VoidCallback? posButtonAction,
    String? negButtonTitle,
    bool isCancellable = true,
    VoidCallback? negButtonAction}) {
  List<Widget> actions = [];
  if (posButtonTitle != null) {
    actions.add(
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          posButtonAction?.call();

        },
        child: Text(posButtonTitle),
      ),



    );
    if(negButtonTitle != null){
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negButtonAction?.call();
          },
          child: Text(negButtonTitle),
        ),
      );
    }
  }
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(content: Text(message), actions: actions);
      },
      barrierDismissible: isCancellable

      );
}

void showLoadingDialog(BuildContext context,{required String message, bool isCancellable = true}) {
  showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 20,
              ),
              Text( message ),
            ],
          ),

        );
      },
      barrierDismissible: isCancellable
      );
}
void hideLoadingDialog(BuildContext context) {
  Navigator.pop(context);
}


void showMessage() {}
