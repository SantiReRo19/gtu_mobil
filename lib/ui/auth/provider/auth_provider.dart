import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/config/providers/auth_repository_provider.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/domain/entities/user.dart';
import 'package:gtu_mobile/domain/repositories/auth_repository.dart';
import 'package:gtu_mobile/ui/common/handlers/process_handler.dart';
import 'package:gtu_mobile/ui/common/providers/process_handler_provider.dart';

final authProvider = Provider.autoDispose<AuthProvider>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final processHandler = ref.watch(processHandlerProvider);
  final goRouter = ref.watch(appRouteProvider);
  return AuthProvider(authRepository, processHandler, goRouter);
});

class AuthProvider {
  final AuthRepository _authRepository;
  final ProcessHandler _processHandler;
  final GoRouter _goRouter;

  AuthProvider(this._authRepository, this._processHandler, this._goRouter);

  Future<void> signIn(String email, String password) async {
    try {
      _processHandler.showProgressDialog();
      await _authRepository.signInWithEmailAndPassword(email, password);
      _processHandler.dismissProgressDialog();
      _goRouter.goNamed(AppRouterName.busFleet);
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: 'Algo salió mal',
        message: e.toString(),
      );
    }
  }

  void signOut() async {
    try {
      _processHandler.showProgressDialog();
      await _authRepository.signOut();
      _processHandler.dismissProgressDialog();
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: 'Ocurrió un error',
        message: 'Se cerrará la sesión de forma forzada',
      );
    } finally {
      _goRouter.goNamed(AppRouterName.login);
    }
  }

  void signUp(String name, String email, String password) async {
    try {
      _processHandler.showProgressDialog();
      await _authRepository.signUp(name, email, password);
      _processHandler.dismissProgressDialog();
      _goRouter.goNamed(AppRouterName.busFleet);
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: 'Algo salió mal',
        message: e.toString(),
      );
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final user = await _authRepository.getCurrentUser();
      return user;
    } catch (e) {
      _processHandler.openModalDialogAlert(
        title: 'Algo salió mal',
        message: e.toString(),
        onConfirm: _goRouter.pop,
      );
      rethrow;
    }
  }

  void resetPassword(String email) async {
    try {
      _processHandler.showProgressDialog();
      await _authRepository.resetPassword(email);
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogSucess(
        title: 'Éxito',
        message:
            'Por favor revisa tu correo electrónico para restablecer tu contraseña.',
        onConfirm: _goRouter.pop,
      );
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: 'Algo salió mal',
        message: e.toString(),
      );
    }
  }
}
