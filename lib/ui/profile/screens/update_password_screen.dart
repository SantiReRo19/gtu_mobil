import 'package:flutter/material.dart';
import 'package:gtu_mobile/ui/profile/widgets/form_update_password.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Text(
                'Mantener la seguridad de tu cuenta es importante',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ingresa tu contraseña actual y la nueva contraseña que deseas establecer',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 26),
              FormUpdatePassword(
                formKey: formKey,
                currentPasswordController: _oldPasswordController,
                passwordController: _newPasswordController,
                confirmPasswordController: _confirmPasswordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
