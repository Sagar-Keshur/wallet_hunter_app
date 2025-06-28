part of 'widgets.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    required this.title,
    required this.description,
    required this.positiveButtonText,
    required this.negativeButtonText,
    required this.onPositiveButtonPressed,
    required this.onNegativeButtonPressed,
    this.isLoading = false,
    this.extraInfoWidget,
    this.textAlign = TextAlign.center,
    this.primaryButtonType = ButtonType.primary,
    super.key,
  });

  final String title;
  final String description;
  final String positiveButtonText;
  final String negativeButtonText;
  final Future<void> Function() onPositiveButtonPressed;
  final Future<void> Function() onNegativeButtonPressed;
  final bool isLoading;
  final Widget? extraInfoWidget;
  final TextAlign textAlign;
  final ButtonType primaryButtonType;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final dialogWidth = screenWidth - (AppSpacing.paddingMargin * 2);

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(
        top: AppSpacing.paddingMargin,
        left: AppSpacing.paddingMargin,
        right: AppSpacing.paddingMargin,
        bottom:
            AppSpacing.paddingCompact + MediaQuery.of(context).padding.bottom,
      ),
      alignment: Alignment.bottomCenter,
      backgroundColor: AppColors.bgPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusMedium),
          topRight: Radius.circular(AppSpacing.radiusMedium),
        ),
      ),
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.spacingMd),
            Center(
              child: Text(
                title,
                style: AppStyles.h6,
              ),
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.spacingXs),
              Text(
                description,
                textAlign: textAlign,
                style: AppStyles.b3,
              ),
            ],
            const SizedBox(height: AppSpacing.spacing4xl),
            if (extraInfoWidget != null) extraInfoWidget!,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: positiveButtonText,
                    buttonType: ButtonType.secondary,
                    onPressed: onPositiveButtonPressed,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingSm),
                Expanded(
                  child: AppButton(
                    text: negativeButtonText,
                    isLoading: isLoading,
                    buttonType: primaryButtonType,
                    onPressed: onNegativeButtonPressed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spacingMd),
          ],
        ),
      ),
    );
  }
}
