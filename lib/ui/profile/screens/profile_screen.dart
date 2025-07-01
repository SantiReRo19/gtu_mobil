import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/ui/auth/provider/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil'), centerTitle: true),
      body: FutureBuilder(
        future: ref.read(authProvider).getCurrentUser(),
        builder: (context, asyncSnapshot) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Nombre de usuario'),
                subtitle: Text(asyncSnapshot.data?.name ?? '-'),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Correo electrónico'),
                subtitle: Text(asyncSnapshot.data?.email ?? '-'),
              ),
              //Cambiar contraseña
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Cambiar contraseña'),
                onTap: () {
                  context.pushNamed(AppRouterName.updatePassword);
                },
              ),

              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  ref.read(authProvider).signOut();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
