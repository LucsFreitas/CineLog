import 'package:flutter/material.dart';

class CineLogField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> hideTextVN;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final IconButton? suffixIconButton;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  CineLogField(
      {super.key,
      required this.label,
      this.obscureText = false,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.focusNode,
      this.textInputAction,
      this.onFieldSubmitted,
      this.suffixIconButton,
      this.controller,
      this.validator})
      : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado com conjunto com o suffixIconButton'),
        hideTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hideTextVN,
      builder: (_, hideTextValue, child) {
        return TextFormField(
          autovalidateMode: autovalidateMode,
          controller: controller,
          validator: validator,
          obscureText: hideTextValue,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          hideTextVN.value = !hideTextValue;
                        },
                        icon: hideTextValue == true
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        style: ButtonStyle(),
                      )
                    : null),
          ),
        );
      },
    );
  }
}
