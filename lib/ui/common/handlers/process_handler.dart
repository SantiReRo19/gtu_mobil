import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtu_mobile/ui/common/widgets/custom_modal.dart';

class ProcessHandler {
  final BuildContext context;

  ProcessHandler(this.context);

  void showProgressDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withValues(alpha: 0.7),
            child: Center(
              child: SizedBox(
                width: 42,
                height: 42,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ),
          ),
        );
      },
    );
  }

  void dismissProgressDialog() {
    Navigator.pop(context);
  }

  Future<T?> _openModalDialog<T>(
    ModalType type, {
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) async {
    return await showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomModel(
          title: title,
          message: message,
          type: type,
          onConfirm: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
        );
      },
    );
  }

  void openModalDialogSucess({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    _openModalDialog(
      ModalType.success,
      title: title,
      message: message,
      onConfirm: onConfirm,
    );
  }

  void openModalDialogAlert({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    _openModalDialog(
      ModalType.alert,
      title: title,
      message: message,
      onConfirm: onConfirm,
    );
  }
}
