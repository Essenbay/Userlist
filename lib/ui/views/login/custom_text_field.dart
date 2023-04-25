import 'package:flutter/material.dart';
import 'package:qazaqsoft_test/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Function(String)? onTextChanged;
  final bool obscureText;

  const CustomTextField({Key? key, required this.label, this.onTextChanged, this.obscureText = false})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            fontSize: 18,
            color: _focused ? AppColors.primary : AppColors.unfocusedGrey,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.unfocusedGrey),
          ),
        ),
        onChanged: (value) {
          if (widget.onTextChanged != null) {
            widget.onTextChanged!(value);
          }
        },
        onTap: () {
          setState(() {
            _focused = true;
          });
        },
        onEditingComplete: () {
          setState(() {
            _focused = false;
          });
        },
        onSubmitted: (value) {
          setState(() {
            _focused = false;
          });
        });
  }
}
