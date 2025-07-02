import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/ui/auth/widgets/form_login.dart';
import 'package:gtu_mobile/ui/common/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                'Bienvenido',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Inicia sesión para continuar',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 26),
              FormLogin(
                formKey: _formKey,
                emailController: _usernameController,
                passwordController: _passwordController,
              ),
              const SizedBox(height: 26),
              CustomTextButton(
                text: "¿Olvidaste tu contraseña?",
                onPressed: () {
                  context.pushNamed(AppRouterName.resetPassword);
                },
              ),
              const SizedBox(height: 10),
              CustomTextButton(
                text: "¿No tienes una cuenta? Regístrate",
                onPressed: () {
                  context.pushNamed(AppRouterName.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
