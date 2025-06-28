part of 'widgets.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({required this.onTap, super.key});

  final AsyncCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.white,
          size: 24,
        ),
      ),
    );
  }
}

class AppCircleButton extends StatelessWidget {
  const AppCircleButton({
    required this.onTap,
    this.isLoading = false,
    super.key,
  }) : icon = Icons.close_rounded;

  const AppCircleButton.delete({
    required this.onTap,
    this.isLoading = false,
    super.key,
  }) : icon = Icons.delete_rounded;

  final AsyncCallback onTap;

  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          shape: BoxShape.circle,
        ),
        child: isLoading
            ? const AppCircularProgressIndicator()
            : Icon(icon, size: 24, color: AppColors.white),
      ),
    );
  }
}
