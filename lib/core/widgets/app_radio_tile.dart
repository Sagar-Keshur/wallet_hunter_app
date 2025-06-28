part of 'widgets.dart';

class AppRadioTile extends StatelessWidget {
  const AppRadioTile({
    required this.title,
    super.key,
    this.isSelected = false,
    this.onTap,
    this.isDisabled = false,
  });

  final String title;
  final bool isSelected;
  final void Function()? onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.paddingComfortable,
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.paddingComfortable,
            horizontal: AppSpacing.paddingRelaxed,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
            border: Border.all(
              color: isSelected
                  ? AppColors.borderActive
                  : AppColors.borderDisabled,
            ),
          ),
          child: Row(
            children: [
              AppRadio(
                isSelected: isSelected,
                onTap: onTap,
              ),
              const SizedBox(width: AppSpacing.paddingComfortable),
              Text(
                title,
                style: AppStyles.label1.copyWith(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
