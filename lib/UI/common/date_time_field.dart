import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/theme_provider.dart';
import 'package:to_do/UI/common/material_text_form_field.dart';

class TimeField extends StatelessWidget {
  String title;
  String hint;
  VoidCallback onClick;

  TimeField({super.key, required this.title, required this.hint , required this.onClick});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: isDark? Theme.of(context).textTheme.titleSmall : Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
      MaterialTextFormField(
          hint: hint,
          readOnly: true,
        onClick: onClick,

      ),
      ],
    );
  }
}
