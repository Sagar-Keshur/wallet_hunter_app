part of 'widgets.dart';

class AppSheetHandleWidget extends StatelessWidget {
  const AppSheetHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 4,
        width: 58,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        ),
      ),
    );
  }
}
