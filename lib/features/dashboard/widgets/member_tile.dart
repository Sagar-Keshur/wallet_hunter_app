import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/family_member_display_model.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/widgets/widgets.dart';
import '../store/dashboard_store.dart';

class MemberTile extends StatelessWidget {
  const MemberTile({
    required this.member,
    this.isFamilyHead = false,
    super.key,
  });

  final FamilyMemberDisplay member;
  final bool isFamilyHead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
        border: Border.all(
          color: member.isLinked
              ? member.color.withValues(alpha: 0.3)
              : AppColors.borderDisabled,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.spacingMd),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: member.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
            border: Border.all(
              color: member.color.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Center(
            child: member.photo != null
                ? ClipOval(
                    child: Image.network(
                      member.photo!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(member.avatar, style: const TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(
          member.name,
          style: AppStyles.b1.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          member.relation,
          style: AppStyles.label1.copyWith(color: AppColors.textSecondary),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacingSm,
                vertical: AppSpacing.spacingXs,
              ),
              decoration: BoxDecoration(
                color: member.isLinked
                    ? AppColors.familySuccess.withValues(alpha: 0.1)
                    : AppColors.familyWarning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMinimal),
              ),
              child: Text(
                member.isLinked ? 'Linked' : 'Pending',
                style: AppStyles.label2.copyWith(
                  color: member.isLinked
                      ? AppColors.familySuccess
                      : AppColors.familyWarning,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isFamilyHead) ...[
              const SizedBox(width: AppSpacing.spacingSm),
              GestureDetector(
                onTap: () => _showDeleteConfirmation(context, member),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingXs),
                  decoration: BoxDecoration(
                    color: AppColors.familyWarning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMinimal,
                    ),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColors.familyWarning,
                    size: 20,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    FamilyMemberDisplay member,
  ) async {
    await AppRemoveMemberDialog.show(context).then((confirmed) async {
      if (confirmed == true) {
        await context.read<DashboardStore>().deleteMember(member.member.id);
      }
    });
  }
}
