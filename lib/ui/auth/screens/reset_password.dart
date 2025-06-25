import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/ui/auth/widgets/form_reset_password.dart';
import 'package:gtu_mobile/ui/common/widgets/custom_text_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .15),
              const Text(
                '¡Qué bueno verte de nuevo!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ingresa tu correo electrónico para restablecer tu contraseña',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 26),

              FormResetPassword(
                emailController: _emailController,
                formKey: _formKey,
              ),

              const SizedBox(height: 26),

              CustomTextButton(
                text: "Volver a iniciar sesión",
                onPressed: context.pop,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
