import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textStyles => Theme.of(this).textTheme;

  // Custom getters for your design system
  Color get primaryColor => colors.primary;

  Color get secondaryColor => colors.secondary;

  Color get backgroundColor => colors.surface;

  Color get surface => colors.surface;
}

extension StringCasingExtension on String {
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : word[0].toUpperCase() + word.substring(1).toLowerCase(),
        )
        .join(' ');
  }
}

// extension RoundedTextFormFieldExtensions on RoundedTextFormField {
//   // Email field factory
//   static RoundedTextFormField email({
//     Key? key,
//     TextEditingController? controller,
//     FocusNode? focusNode,
//     FocusNode? nextFocusNode,
//     String? hintText = 'Enter your email',
//     String? labelText = 'Email',
//     void Function(String)? onChanged,
//     void Function(String)? onFieldSubmitted,
//     bool readOnly = false,
//   }) {
//     return RoundedTextFormField(
//       key: key,
//       controller: controller,
//       focusNode: focusNode,
//       nextFocusNode: nextFocusNode,
//       hintText: hintText,
//       labelText: labelText,
//       readOnly: readOnly,
//       prefixIcon: Icons.email_outlined,
//       keyboardType: TextInputType.emailAddress,
//       textInputAction: TextInputAction.next,
//       onChanged: onChanged,
//       onFieldSubmitted: onFieldSubmitted,
//       validator: Validator.validateEmail,
//     );
//   }
//
//   // Password field factory
//   static RoundedTextFormField password({
//     Key? key,
//     TextEditingController? controller,
//     FocusNode? focusNode,
//     FocusNode? nextFocusNode,
//     String? hintText = 'Enter your password',
//     String? labelText = 'Password',
//     void Function(String)? onChanged,
//     void Function(String)? onFieldSubmitted,
//     int minLength = 8,
//   }) {
//     return RoundedTextFormField(
//       key: key,
//       controller: controller,
//       focusNode: focusNode,
//       nextFocusNode: nextFocusNode,
//       hintText: hintText,
//       labelText: labelText,
//       prefixIcon: Icons.lock_outline,
//       obscureText: true,
//       textInputAction: TextInputAction.done,
//       onChanged: onChanged,
//       onFieldSubmitted: onFieldSubmitted,
//       showValidationIcon: false,
//       validator: Validator.validatePassword,
//     );
//   }
//
//   // Confirm Password field factory
//   static RoundedTextFormField confirmPassword({
//     Key? key,
//     TextEditingController? controller,
//     FocusNode? focusNode,
//     FocusNode? nextFocusNode,
//     String? hintText = 'Confirm your password',
//     String? labelText = 'Confirm Password',
//     void Function(String)? onChanged,
//     void Function(String)? onFieldSubmitted,
//     required TextEditingController originalPassword,
//     int minLength = 8,
//   }) {
//     return RoundedTextFormField(
//       key: key,
//       controller: controller,
//       focusNode: focusNode,
//       nextFocusNode: nextFocusNode,
//       hintText: hintText,
//       labelText: labelText,
//       prefixIcon: Icons.lock_outline,
//       obscureText: true,
//       textInputAction: TextInputAction.done,
//       onChanged: onChanged,
//       onFieldSubmitted: onFieldSubmitted,
//       showValidationIcon: false,
//       validator: (value) =>
//           Validator.validateConfirmPassword(value, originalPassword.text),
//     );
//   }
//
//   // Name field factory
//   static RoundedTextFormField fullName({
//     Key? key,
//     TextEditingController? controller,
//     FocusNode? focusNode,
//     FocusNode? nextFocusNode,
//     String? hintText = 'Enter your name',
//     String? labelText = 'Fullname',
//     void Function(String)? onChanged,
//     void Function(String)? onFieldSubmitted,
//   }) {
//     return RoundedTextFormField(
//       key: key,
//       controller: controller,
//       focusNode: focusNode,
//       nextFocusNode: nextFocusNode,
//       hintText: hintText,
//       labelText: labelText,
//       prefixIcon: Icons.person_outline,
//       textInputAction: TextInputAction.next,
//       onChanged: onChanged,
//       onFieldSubmitted: onFieldSubmitted,
//       showValidationIcon: false,
//       validator: Validator.validateUserName,
//     );
//   }
//
//   // Phone field factory
//   static RoundedTextFormField phone({
//     Key? key,
//     TextEditingController? controller,
//     FocusNode? focusNode,
//     FocusNode? nextFocusNode,
//     String? hintText = 'Enter your phone number',
//     String? labelText = 'Phone Number',
//     void Function(String)? onChanged,
//     void Function(String)? onFieldSubmitted,
//     bool validate = true,
//   }) {
//     return RoundedTextFormField(
//       key: key,
//       controller: controller,
//       focusNode: focusNode,
//       nextFocusNode: nextFocusNode,
//       hintText: hintText,
//       labelText: labelText,
//       prefixIcon: Icons.local_phone_outlined,
//       keyboardType: TextInputType.phone,
//       textInputAction: TextInputAction.next,
//       onChanged: onChanged,
//       onFieldSubmitted: onFieldSubmitted,
//       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//       validator: validate ? Validator.validatePhone : null,
//     );
//   }
//
//   // Search field factory
//   static RoundedTextFormField search({
//     Key? key,
//     TextEditingController? controller,
//     FocusNode? focusNode,
//     String? hintText = 'Search',
//     void Function(String)? onChanged,
//     void Function(String)? onFieldSubmitted,
//     VoidCallback? onClear,
//   }) {
//     return RoundedTextFormField(
//       key: key,
//       controller: controller,
//       focusNode: focusNode,
//       hintText: hintText,
//       prefixIcon: Icons.search_rounded,
//       textInputAction: TextInputAction.search,
//       onChanged: onChanged,
//       onFieldSubmitted: onFieldSubmitted,
//       showValidationIcon: false,
//       suffix: controller?.text.isNotEmpty == true
//           ? IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           controller?.clear();
//           onClear?.call();
//         },
//       )
//           : null,
//     );
//   }
// }
