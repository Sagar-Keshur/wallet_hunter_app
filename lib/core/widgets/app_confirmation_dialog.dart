part of 'widgets.dart';

class AppConformationDialog extends StatelessWidget {
  const AppConformationDialog({
    required this.title,
    this.primaryButtonText = 'Yes',
    this.secondaryButtonText = 'Cancel',
    super.key,
  });

  final String title;
  final String primaryButtonText;
  final String secondaryButtonText;

  static Future<Bool?> showDeleteAccount<Bool>(
    BuildContext context, {
    String title = 'Are you sure you want to delete your account permanently?',
  }) {
    return showDialog<Bool>(
      context: context,
      builder: (context) => AppConformationDialog(title: title),
    );
  }

  static Future<Bool?> showMessage<Bool>(
    BuildContext context, {
    required String message,
    String primaryButtonText = 'Ok',
    String secondaryButtonText = '',
    bool barrierDismissible = true,
  }) {
    return showDialog<Bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppConformationDialog(
        title: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
      ),
    );
  }

  static Future<Bool?> show<Bool>(
    BuildContext context, {
    required String message,
    String primaryButtonText = 'Yes',
    String secondaryButtonText = 'Cancel',
  }) {
    return showDialog<Bool>(
      context: context,
      builder: (context) => AppConformationDialog(
        title: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMargin,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMargin,
        vertical: AppSpacing.paddingOpen,
      ),
      backgroundColor: AppColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      content: SizedBox(
        width: context.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: AppStyles.b1),
            const SizedBox(height: AppSpacing.spacing4xl),
            AppButton(
              text: primaryButtonText,
              onPressed: () async => getIt<RouteHelper>().pop(true),
            ),
            if (secondaryButtonText.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.spacingSm),
              AppButton(
                text: secondaryButtonText,
                buttonType: ButtonType.secondary,
                onPressed: () async => getIt<RouteHelper>().pop(false),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppRemoveMemberDialog extends StatelessWidget {
  const AppRemoveMemberDialog({super.key});

  static Future<Bool?> show<Bool>(BuildContext context) {
    return showDialog<Bool>(
      context: context,
      builder: (context) => const AppRemoveMemberDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgPrimary,
          borderRadius: BorderRadius.circular(32),
        ),
        width: context.width,
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spacing4xl,
          horizontal: AppSpacing.spacing4xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to remove this member?',
              style: AppStyles.h6.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.spacing4xl),
            AppButton(
              text: 'Delete',
              onPressed: () async => getIt<RouteHelper>().pop(true),
            ),
            const SizedBox(height: AppSpacing.spacingXl),
            InkWell(
              onTap: () => getIt<RouteHelper>().pop(false),
              child: const Text('Go Back', style: AppStyles.b3),
            ),
          ],
        ),
      ),
    );
  }
}
