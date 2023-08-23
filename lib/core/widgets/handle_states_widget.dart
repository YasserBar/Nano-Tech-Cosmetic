import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';

class HandleStatesWidget extends StatelessWidget {
  final StateType stateType;
  final bool isDialog;
  final void Function()? onPressedTryAgain;

  const HandleStatesWidget({
    Key? key,
    required this.stateType,
    this.onPressedTryAgain,
    this.isDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 70,
        ),
        Center(
          child: SvgPicture.asset(
            stateType.getIcon(),
          ),
        ),
          const SizedBox(
            height: 50,
          ),
        if (stateType == StateType.offline ||
            stateType == StateType.unexpectedProblem ||
            stateType == StateType.internalServerProblem)
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
