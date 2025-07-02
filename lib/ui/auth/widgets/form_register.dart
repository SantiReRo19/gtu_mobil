import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/auth/provider/auth_provider.dart';
import 'package:gtu_mobile/ui/common/widgets/custom_button.dart';
import 'package:gtu_mobile/utils/validations.dart';

class FormRegister extends ConsumerWidget {
  const FormRegister({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: validateName,
            decoration: const InputDecoration(
              labelText: 'Nombre de usuario',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
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
              final name = nameController.text.trim();
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              ref.read(authProvider).signUp(name, email, password);
            },
            text: "Registrarse",
          ),
        ],
      ),
    );
  }
}
