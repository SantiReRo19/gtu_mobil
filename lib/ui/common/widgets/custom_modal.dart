import 'package:flutter/material.dart';
import 'package:gtu_mobile/ui/common/widgets/custom_button.dart';

enum ModalType { alert, success }

class CustomModel extends StatelessWidget {
  const CustomModel({
    super.key,
    required this.onConfirm,
    this.icon,
    this.type = ModalType.success,
    required this.title,
    required this.message,
    this.confirmText,
  });
  final VoidCallback onConfirm;
  final Widget? icon;
  final ModalType type;
  final String title;
  final String message;
  final String? confirmText;

  Color get primaryIconColor {
    switch (type) {
      case ModalType.alert:
        return const Color(0xFFD32F2F);
      case ModalType.success:
        return const Color(0xFF388E3C);
    }
  }

  Color get primaryColor {
    switch (type) {
      case ModalType.alert:
        return primaryIconColor.withValues(alpha: 0.1);
      case ModalType.success:
        return primaryIconColor.withValues(alpha: 0.1);
    }
  }

  IconData get primaryIcon {
    switch (type) {
      case ModalType.alert:
        return Icons.warning_rounded;
      case ModalType.success:
        return Icons.check_circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: SizedBox(
        height: 320,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(42.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type == ModalType.success)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      primaryIconColor,
                      BlendMode.srcIn,
                    ),
                    child: icon ?? Icon(primaryIcon),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          primaryIconColor,
                          BlendMode.srcIn,
                        ),
                        child: icon ?? Icon(primaryIcon),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: type == ModalType.success
                      ? TextAlign.center
                      : TextAlign.left,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Color(0xFF1C1C1C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                child: Text(
                  message,
                  textAlign: type == ModalType.success
                      ? TextAlign.center
                      : TextAlign.left,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                  maxLines: 4,
                ),
              ),
              const Spacer(),

              CustomButton(
                onPressed: onConfirm,
                text: confirmText ?? 'Aceptar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
