import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';

class HandleStatesWidget extends StatelessWidget {
  final StateType errorType;
  final bool isDialog;
  final void Function()? onPressedTryAgain;

  const HandleStatesWidget({
    Key? key,
    required this.errorType,
    this.onPressedTryAgain,
    this.isDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 100,
        ),
        Center(
          child: SvgPicture.asset(
            errorType.getIcon(),
          ),
        ),
          const SizedBox(
            height: 50,
          ),
        if (errorType == StateType.offline ||
            errorType == StateType.unexpectedProblem ||
            errorType == StateType.internalServerProblem)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButtonAuth(
              text: AppTranslationKeys.tryAgain.tr,
              onPressed: onPressedTryAgain,
            ),
          ),
      ],
    );
  }
}
