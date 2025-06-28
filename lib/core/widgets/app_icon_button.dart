part of 'widgets.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  }) : iconData = null;

  const AppIconButton.withIconData({
    required this.iconData,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  }) : icon = null;

  final String? icon;
  final IconData? iconData;
  final AsyncCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Widget? iconWidget;

    if (icon != null) {
      iconWidget = SvgPicture.asset(
        icon!,
        height: 24,
        width: 24,
      );
    } else if (iconData != null) {
      iconWidget = Icon(iconData, size: 24, color: AppColors.white);
    } else {
      iconWidget = const SizedBox.shrink();
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spacingLg,
          horizontal: AppSpacing.spacing2xl,
        ),
        decoration: BoxDecoration(
          color: AppColors.natural900,
          borderRadius: BorderRadius.circular(50),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(AppColors.natural100),
                ),
              )
            : iconWidget,
      ),
    );
  }
}
