import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';

class AppValidator {
  static const emailRegex =
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
  static const phoneRegex = r'^\d{9}$';
  static const numberRegex = r'^[0-9]+$';
  static const passwordRegex8CharactersInLength = r'^.{8,}';
  static const nameRegex = r'^[\u0600-\u06FFa-zA-Z\s]+$';

  static String? validateEmail(String? inputEmail) {
    if (inputEmail == null || inputEmail.isEmpty) {
      return AppTranslationKeys.emailIsRequired.tr;
    } else if (!RegExp(emailRegex).hasMatch(inputEmail)) {
      return AppTranslationKeys.emailIsNotInvalid.tr;
    } else if (!inputEmail.endsWith('@gmail.com')) {
      return AppTranslationKeys.emailMustEndGmail.tr;
    }
    return null;
  }

  static String? validateName(String? inputName) {
    if (inputName == null || inputName.isEmpty) {
      return AppTranslationKeys.nameIsRequired.tr;
    } else if (!RegExp(nameRegex).hasMatch(inputName)) {
      return AppTranslationKeys.nameIsNotInvalid.tr;
    }
    return null;
  }

  static String? validateRequired(String? inputEmail) {
    if (inputEmail == null || inputEmail.isEmpty) {
      return AppTranslationKeys.thisFieldIsRequired.tr;
    }
    return null;
  }

  static String? validateNumber(String? inputEmail) {
    if (inputEmail == null || inputEmail.isEmpty) {
      return AppTranslationKeys.thisFieldIsRequired.tr;
    }
    if (!RegExp(numberRegex).hasMatch(inputEmail)) {
      return AppTranslationKeys.thisFieldIsNotNumber.tr;
    }
    return null;
  }

  static String? validatePhone(String? inputNumber) {
    if (inputNumber == null ||
        inputNumber.isEmpty) {
      return AppTranslationKeys
          .phoneNumberIsRequired.tr;
    }
    if (inputNumber.length == 9||inputNumber.length == 10) {
      if((inputNumber.length == 9 && inputNumber.startsWith('7'))||(inputNumber.length == 10 && inputNumber.startsWith('07'))){
        return null;
      }
      return AppTranslationKeys
          .phonePatternIsNotInvalid
          .tr;
    }
    return AppTranslationKeys
        .thePhoneNumberShouldConsistOf9Digits
        .tr;
  }

  static String? validatePassword(String? inputPassword) {
    if (inputPassword == null || inputPassword.isEmpty) {
      return AppTranslationKeys.passwordIsRequired.tr;
    } else if (!RegExp(passwordRegex8CharactersInLength)
        .hasMatch(inputPassword)) {
      return AppTranslationKeys.itShouldBeAtLeast8CharactersLong.tr;
    }
    return null;
  }

  static String? validateConflictPassword(String? inputPassword, String? pass) {
    if (inputPassword == null || inputPassword.isEmpty) {
      return AppTranslationKeys.passwordConfirmationIsRequired.tr;
    } else if (inputPassword != pass) {
      return AppTranslationKeys.thereIsNoMatch.tr;
    }
    return null;
  }

  static bool startsWithEnglishChar(String input) {
    RegExp englishCharRegex = RegExp(r'^[a-zA-Z0-9٠-٩]');
    return englishCharRegex.hasMatch(input);
  }

  static bool isOnlySpaces(String input) {
    return input.trim().isEmpty;
  }

  static bool isValidIraqPhoneNumber(String input) {
    RegExp phoneNumberRegex = RegExp(r'^(00|\+ ?964|0 ?964)(-? ?\d{9,13})$');
    return phoneNumberRegex.hasMatch(input);
  }
}
/*
List<String> phoneNumbers = [
      "00964215195745",
      "00 964215195745",
      "00964 215195745",
      "00 964 215195745",
      "00-964215195745",
      "00964-215195745",
      "00-964-215195745",
      "0964215195745",
      "0 964215195745",
      "0964 215195745",
      "0 964 215195745",
      "0-964215195745",
      "0964-215195745",
      "0-964-215195745",
      "+964215195745",
      "+964215195745",
      "+964 215195745",
      "+964215195745",
      "+964-215195745",
      "+ 964215195745",
      "+ 964215195745",
      "+ 964 215195745",
      "+ 964215195745",
      "+ 964-215195745",
      "0215195745",
      "215195745",
    ];

    for (String phoneNumber in phoneNumbers) {
      print("$phoneNumber is valid: ${AppValidator.isValidIraqPhoneNumber(phoneNumber)}");
    }
 */
