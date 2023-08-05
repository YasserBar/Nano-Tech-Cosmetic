import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool isObscureText;
  final bool isTextArea;
  final TextInputType inputType;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final void Function()? onTap;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.isObscureText = false,
    this.isTextArea = false,
    this.inputType = TextInputType.text,
    this.controller,
    this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisibleText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
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
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          onTap: widget.onTap,
          decoration: InputDecoration(
            filled: false,
            suffixIcon: widget.isObscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisibleText = !isVisibleText;
                      });
                    },
                    icon: isVisibleText
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  )
                : null,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.danger1,
                width: 3,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.danger2,
                width: 3,
              ),
            ),
            contentPadding: const EdgeInsets.all(15),
          ),
          keyboardType: widget.inputType,
          obscureText: widget.isObscureText && !isVisibleText,
          maxLines: widget.isTextArea ? 7 : 1,
          minLines: widget.isTextArea ? 5 : 1,
          readOnly: widget.onTap != null,
        ),
      ],
    );
  }
}
