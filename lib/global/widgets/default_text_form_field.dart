import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultFormField extends StatelessWidget {
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final Text? labelWidget;
  final Text? hintWidget;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? formatters;
  final bool? obscureText;
  const DefaultFormField({super.key,
    this.obscureText,
    this.maxLines,
    this.hintText,
    this.labelText,
    this.labelWidget,
    this.hintWidget,
    this.prefix,
    this.suffix,
    this.validator,
    required this.controller,
    this.onFieldSubmitted,
    this.textInputType,
    this.textInputAction,
    this.onChanged, this.focusNode,
    this.formatters,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,),
      child: TextFormField(
        focusNode:focusNode,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: textInputType ?? TextInputType.name,
        textInputAction: textInputAction ?? TextInputAction.done,
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        inputFormatters: formatters,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          label: labelWidget,
          suffixIcon: suffix,
          prefixIcon: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        obscureText: obscureText??false,
      ),
    );
  }
}
