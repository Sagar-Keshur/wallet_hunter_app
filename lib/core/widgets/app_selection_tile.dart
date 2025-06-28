part of 'widgets.dart';

class AppSelectionTile extends StatelessWidget {
  const AppSelectionTile({
    required this.isSelected,
    required this.onTap,
    required this.label,
    super.key,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.paddingComfortable),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.paddingComfortable,
            horizontal: AppSpacing.paddingRelaxed,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.natural100 : AppColors.natural800,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppStyles.b2.copyWith(
              color: isSelected ? AppColors.natural1000 : AppColors.natural100,
            ),
          ),
        ),
      ),
    );
  }
}
