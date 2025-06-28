part of 'widgets.dart';

class AppRadio extends StatelessWidget {
  const AppRadio({
    required this.isSelected,
    this.onTap,
    super.key,
  });

  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              height: 24,
              width: 24,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.borderActive,
                ),
              ),
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: AppColors.borderActive,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          : Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderDisabled),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
    );
  }
}
