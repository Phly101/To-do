import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/common/text_forms.dart';

class MaterialTextFormField extends StatelessWidget {
  final String hint;
  final int? maxTextLines;
 final VoidCallback? onClick;
 final bool? readOnly;
 final Validator? validator ;

  final TextEditingController? controller;

  const MaterialTextFormField(
      {super.key, required this.hint, this.maxTextLines, this.controller,
      this.onClick,this.readOnly= true, this.validator,
      });

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
    return TextFormField(
      style: isDark ? Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary
      ) : Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),

      onTap: (){
        onClick?.call();
      },
      validator: validator,

      readOnly: readOnly ?? true,
      enableInteractiveSelection: readOnly,
      focusNode: FocusNode(),
      controller: controller,
      decoration: InputDecoration(

        errorStyle: const TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
          labelText: hint,
          labelStyle:isDark? Theme.of(context).textTheme.titleSmall : Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey),
          hintStyle: isDark? Theme.of(context).textTheme.titleSmall : Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto),
      maxLines: maxTextLines,
    );
  }
}
