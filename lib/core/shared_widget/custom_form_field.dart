import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {


  final TextInputType type; 
  final bool isClickable;
  final Function()? onTap;
  final TextEditingController controller ; 
  final String? Function(String?)? validator;
  final String labelText;
  final IconData prefixIcon;
  final bool showCursor;

  const CustomFormField({super.key, required this.type, required this.isClickable, required this.onTap, required this.controller, required this.validator, required this.labelText, required this.prefixIcon,  this.showCursor = true});

  @override
  Widget build(BuildContext context) {
      return TextFormField(
        showCursor: showCursor,

      keyboardType: type,
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(),
      ),
    );
  }
}