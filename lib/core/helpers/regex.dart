// const emailRegex =
//     r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
// const phoneRegex = r'^\d{9}$';
// const passwordRegex8CharactersInLength = r'^.{8,}';
// const nameRegex = r'^[\u0600-\u06FFa-zA-Z\s]+$';

// String? validateEmail(String? inputEmail) {
//   if (inputEmail == null || inputEmail.isEmpty) {
//     return 'البريد الإلكتروني مطلوب';
//   } else if (!RegExp(emailRegex).hasMatch(inputEmail)) {
//     return 'البريد الإلكتروني غير صالح';
//   }
//   return null;
// }

// String? validateName(String? inputName) {
//   if (inputName == null || inputName.isEmpty) {
//     return 'الاسم مطلوب';
//   } else if (!RegExp(nameRegex).hasMatch(inputName)) {
//     return 'الاسم غير صالح';
//   }
//   return null;
// }

// String? validateLastName(String? inputName) {
//   if (inputName == null || inputName.isEmpty) {
//     return 'الشهرة مطلوب';
//   } else if (!RegExp(nameRegex).hasMatch(inputName)) {
//     return 'الشهرة غير صالح';
//   }
//   return null;
// }

// String? validatePhone(String? inputNumber) {
//   if (inputNumber == null || inputNumber.isEmpty) {
//     return 'رقم الهاتف مطلوب';
//   } else if (inputNumber.length != 9) {
//     return 'رقم الهاتف ينبغي أن يتألف من 9 خانات';
//   } else if (!RegExp(phoneRegex).hasMatch(inputNumber)) {
//     return 'رقم هاتف غير صالح';
//   }
//   return null;
// }

// String? validatePassword(String? inputPassword) {
//   if (inputPassword == null || inputPassword.isEmpty) {
//     return 'كلمة المرور مطلوبة';
//   } else if (!RegExp(passwordRegex8CharactersInLength)
//       .hasMatch(inputPassword)) {
//     return 'ينبغي أن تتألف من 8 خانات على الأقل';
//   }
//   return null;
// }


// String? validateConflictPassword(String? inputPassword ,String? pass) {
//   if (inputPassword == null || inputPassword.isEmpty) {
//     return 'تأكيد كلمة المرور مطلوبة';
//   } else if (inputPassword != pass) {
//     return 'لا يوجد تطابق';
//   }
//   return null;
// }
