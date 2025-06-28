part of 'widgets.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.primary,
    this.leadingIcon,
    this.trailingIcon,
    this.isDisabled = false,
    this.isSmall = false,
    this.isFullWidth = true,
    this.isLoading = false,
    super.key,
  });

  final ButtonType buttonType;
  final bool isDisabled;
  final IconData? leadingIcon;
  final AsyncCallback onPressed;
  final String text;
  final IconData? trailingIcon;
  final bool isSmall;
  final bool isFullWidth;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final double paddingTight = isSmall ? 0 : AppSpacing.paddingTight;

    final padding = isSmall
        ? const EdgeInsets.all(AppSpacing.paddingCompressed)
        : const EdgeInsets.all(AppSpacing.paddingComfortable);

    return InkWell(
      onTap: isDisabled || isLoading ? null : onPressed,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
      child: Container(
        padding:
            padding -
            (buttonType == ButtonType.secondary ||
                    buttonType == ButtonType.secondarySmall && !isDisabled
                ? const EdgeInsets.all(1)
                : EdgeInsets.zero),
        decoration: BoxDecoration(
          color: isDisabled
              ? buttonType.getDisabledButtonColor(context)
              : buttonType.getButtonColor(context),
          borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
          border: buttonType.getBorder(context),
        ),
        child: Stack(
          children: [
            if (isFullWidth)
              Align(
                child: isLoading
                    ? _getLoader(context)
                    : _getTextWidget(context),
              ),
            Row(
              mainAxisAlignment: leadingIcon == null && trailingIcon == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (leadingIcon != null) ...[
                  Icon(
                    leadingIcon,
                    color: isDisabled
                        ? AppColors.textSecondary
                        : buttonType.getIconColor(context),
                    size: 24,
                  ),
                  SizedBox(width: paddingTight),
                ],
                if (!isFullWidth)
                  isLoading ? _getLoader(context) : _getTextWidget(context),
                if (trailingIcon != null) ...[
                  SizedBox(width: paddingTight),
                  Icon(
                    trailingIcon,
                    color: isDisabled
                        ? AppColors.textSecondary
                        : buttonType.getIconColor(context),
                    size: 24,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTextWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingCompact,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: buttonType
            .getButtonTextStyle(context)
            .copyWith(
              color: isDisabled
                  ? AppColors.textSecondary
                  : buttonType.getTextColor(context),
            ),
      ),
    );
  }

  Widget _getLoader(BuildContext context) {
    return AppLoader(color: buttonType.getTextColor(context));
  }
}

class AppNextButton extends StatelessWidget {
  const AppNextButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing4xl,
            vertical: AppSpacing.spacingMd,
          ),
          child: Text(
            'Next',
            style: AppStyles.b1.copyWith(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
