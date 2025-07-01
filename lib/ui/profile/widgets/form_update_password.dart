import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/common/widgets/custom_button.dart';
import 'package:gtu_mobile/ui/profile/providers/profile_provider.dart';
import 'package:gtu_mobile/utils/validations.dart';

class FormUpdatePassword extends ConsumerWidget {
  const FormUpdatePassword({
    super.key,
    required this.formKey,
    required this.currentPasswordController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: currentPasswordController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: validateName,
            decoration: const InputDecoration(
              labelText: 'Contraseña actual',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            validator: validatePassword,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: confirmPasswordController,
            validator: (value) {
              return validateConfirmPassword(passwordController.text, value);
            },
            decoration: const InputDecoration(
              labelText: 'Confirmar contraseña',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 26),
          CustomButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (!formKey.currentState!.validate()) {
                return;
              }
              final currentPassword = currentPasswordController.text.trim();
              final password = passwordController.text.trim();
              ref
                  .read(profileProvider)
                  .updatePassword(currentPassword, password);
            },
            text: "Actualizar contraseña",
          ),
        ],
      ),
    );
  }
}
