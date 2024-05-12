import 'package:flutter/material.dart';

// Básicamente, todos los widgets personalizados acaban extendiendo otros widgets que ya existen en Flutter.

class CustomTextFormField extends StatelessWidget {

  // Los parámetros que espero para personalizar este input.
  // La firma del onChanged tiene que coincidir con la firma que tiene en onChanged en mi TextFormField.
  // Igual con la firma del validator.
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.onChanged,
    this.validator
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      // borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(40)
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,

      // Se usa decoration para cambiar la apariencia física del input.
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),

        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: errorMessage,
        focusColor: colors.primary,
        // prefixIcon: Icon(Icons.supervised_user_circle_outlined, color: colors.primary)
      ),
    );
  }
}
