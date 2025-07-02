import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/auth/provider/auth_provider.dart';
import 'package:gtu_mobile/ui/common/widgets/custom_button.dart';
import 'package:gtu_mobile/utils/validations.dart';

class FormLogin extends ConsumerWidget {
  const FormLogin({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

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
              labelText: 'Correo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.send,
            validator: validatePassword,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
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
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              ref.read(authProvider).signIn(email, password);
            },
            text: "Iniciar sesión",
          ),
        ],
      ),
    );
  }
}
