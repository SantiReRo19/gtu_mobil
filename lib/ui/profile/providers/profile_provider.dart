import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/config/providers/user_repository_provider.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/domain/repositories/user_repository.dart';
import 'package:gtu_mobile/ui/common/handlers/process_handler.dart';
import 'package:gtu_mobile/ui/common/providers/process_handler_provider.dart';

final profileProvider = Provider.autoDispose<ProfileProvider>((ref) {
  final processHandler = ref.watch(processHandlerProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  final goRouter = ref.watch(appRouteProvider);
  return ProfileProvider(processHandler, userRepository, goRouter);
});

class ProfileProvider {
  final ProcessHandler _processHandler;
  final UserRepository _userRepository;
  final GoRouter _goRouter;
  ProfileProvider(this._processHandler, this._userRepository, this._goRouter);

  void updatePassword(String oldPassword, String newPassword) async {
    try {
      _processHandler.showProgressDialog();
      await _userRepository.updatePassword(oldPassword, newPassword);
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogSucess(
        title: 'Éxito',
        message: 'Contraseña actualizada correctamente.',
        onConfirm: _goRouter.pop,
      );
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: 'Algo salió mal',
        message:
            'No se pudo actualizar la contraseña. Por favor, inténtalo de nuevo más tarde.',
      );
    }
  }
}
