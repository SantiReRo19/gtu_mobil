import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/auth/provider/auth_provider.dart';
import 'package:gtu_mobile/ui/common/widgets/custom_button.dart';
import 'package:gtu_mobile/utils/validations.dart';

class FormResetPassword extends ConsumerWidget {
  const FormResetPassword({
    super.key,
    required this.emailController,
    required this.formKey,
  });
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 26),
          CustomButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) {
                return;
              }
              ref.read(authProvider).resetPassword(emailController.text.trim());
            },
            text: "Restablecer contraseña",
          ),
        ],
      ),
    );
  }
}
