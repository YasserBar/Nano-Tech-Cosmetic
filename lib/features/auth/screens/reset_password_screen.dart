import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAuth(
        child: Column(
          children: [
            const CustomTextField(
              labelText: "Password",
              isObscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            const CustomTextField(
              labelText: "Confirm password",
              isObscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButtonAuth(
              text: "Reset",
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
