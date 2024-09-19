import 'package:flutter/material.dart';
typedef Validator = String? Function(String? text);
class TextForms extends StatefulWidget {
  String title;
  String hint;
  TextInputType keyboardType;
  bool securePassword;
  Validator? validator;
  TextEditingController? controller;


  TextForms(
      {super.key,
      required this.title,
      required this.hint,
      this.keyboardType = TextInputType.text,
      this.securePassword = false,
      this.validator,
      this.controller
      });

  @override
  State<TextForms> createState() => _TextFormsState();
}


class _TextFormsState extends State<TextForms> {
  bool isObscureText = true;
  @override
  void initState() {
    super.initState();
    isObscureText = widget.securePassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextFormField(

            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 16, color: Colors.red),
                suffixIcon: widget.securePassword ?  InkWell(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(isObscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility))
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                hintText: widget.hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey)),
            keyboardType: widget.keyboardType,
            obscureText: isObscureText,
          ),
        ],
      ),
    );
  }
}
