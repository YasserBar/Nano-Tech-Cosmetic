import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool isObscureText;
  final bool isTextArea;
  final TextInputType inputType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.isObscureText = false,
    this.isTextArea = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.gray,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: InputDecoration(
            filled: false,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.gray,
                width: 3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 3,
              ),
            ),
            contentPadding: const EdgeInsets.all(15),
          ),
          keyboardType: inputType,
          obscureText: isObscureText,
          maxLines: isTextArea ? 7 : 1,
          minLines: isTextArea ? 5 : 1,
        ),
      ],
    );
  }
}
