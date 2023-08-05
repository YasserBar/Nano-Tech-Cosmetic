import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

class WidgetsUtils {
  static void showSnackBar(
      {required String title,
      required String message,
      SnackBarType snackBarType = SnackBarType.info,
      int duration = 5}) {
    Get.snackbar(title, message,
        icon: Icon(
          snackBarType == SnackBarType.info
              ? Icons.done
              : snackBarType == SnackBarType.error
                  ? Icons.error
                  : Icons.warning,
          color: AppColors.materialPrimary.shade800,
        ),
        barBlur: 5,
        isDismissible: true,
        colorText: AppColors.materialPrimary.shade800,
        backgroundColor: snackBarType == SnackBarType.info
            ? AppColors.success1
            : snackBarType == SnackBarType.error
                ? AppColors.danger1
                : AppColors.warning1,
        duration: Duration(seconds: duration),
        animationDuration: const Duration(seconds: 1));
  }

  static void showCustomDialog(BuildContext context,
      {required String title,
      List<Widget> children = const [],
      String okText = 'Ok',
      String cancelText = 'Cancel',
      Function()? btnOkOnPress,
      Function()? btnCancelOnPress,
      bool hasBtnCancel=true,
      bool hasBtns=true,
      bool barrierDismissible = true}) {
    showDialog(
      barrierColor: AppColors.white50,
      context: context,
      builder: (context) => Dialog(
        clipBehavior: Clip.hardEdge,
        insetPadding: const EdgeInsets.all(35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: AppColors.gray, width: 3),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  color: AppColors.primary,
                ),
              ),
            ),
            ...children,
            const SizedBox(
              height: 30,
            ),
            if(hasBtns)
            Padding(
              padding: const EdgeInsets.all(30).copyWith(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {
                        if (btnOkOnPress != null) {
                          btnOkOnPress.call();
                        }
                        // Navigator.pop(context);
                      },
                      color: AppColors.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(width: 1, color: AppColors.gray),
                      ),
                      child: Text(
                        okText,
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.white),
                      ),
                    ),
                  ),
                  if(hasBtnCancel)
                  const SizedBox(
                    width: 15,
                  ),
                  if(hasBtnCancel)
                  Expanded(
                    flex: 3,
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {
                        Navigator.pop(context);
                        if (btnCancelOnPress != null) {
                          btnCancelOnPress.call();
                        }
                      },
                      color: AppColors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(width: 1, color: AppColors.gray),
                      ),
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.gray),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
