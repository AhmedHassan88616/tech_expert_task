import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  Function? onChange;
  Function? onTap;
  bool isPassword;
  Function? validate;
  final String label;
  final IconData prefix;
  IconData? suffix;
  Function? suffixPressed;
  bool isClickable;
  bool readOnly;

  DefaultTextFormField({
    Key? key,
    required this.controller,
    required this.type,
    this.onChange,
    this.onTap,
    this.isPassword = false,
    this.validate,
    required this.label,
    required this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      // onFieldSubmitted: (value) {
      //   if (onSubmit != null) onSubmit(value);
      // },
      onChanged: (value) {
        if (onChange != null) onChange!(value);
      },
      onTap: () {
        if (onTap != null) onTap!();
      },
      validator: (value) {
        if (validate != null) return validate!(value);
        return null;
      },
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  if (suffixPressed != null) suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
  }
}
