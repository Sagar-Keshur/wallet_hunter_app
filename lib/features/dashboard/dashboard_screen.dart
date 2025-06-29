import 'package:flutter/material.dart';

import '../../core/enum/button_type.dart';
import '../../core/style_guide/style_guide.dart';
import '../../core/widgets/widgets.dart';
import '../../dependency_manager/dependency_manager.dart';
import '../../router/route_helper.dart';

class FamilyMember {
  FamilyMember({
    required this.name,
    required this.relation,
    required this.avatar,
    required this.isLinked,
    required this.color,
  });
  final String name;
  final String relation;
  final String avatar;
  final bool isLinked;
  final Color color;
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<FamilyMember> _familyMembers = [
    FamilyMember(
      name: 'Mom',
      relation: 'Mother',
      avatar: '👩‍🦰',
      isLinked: true,
      color: AppColors.familyPrimary,
    ),
    FamilyMember(
      name: 'Dad',
      relation: 'Father',
      avatar: '👨‍🦰',
      isLinked: true,
      color: AppColors.familySecondary,
    ),
    FamilyMember(
      name: 'Sister',
      relation: 'Sister',
      avatar: '👧',
      isLinked: false,
      color: AppColors.familyAccent,
    ),
    FamilyMember(
      name: 'Brother',
      relation: 'Brother',
      avatar: '👦',
      isLinked: false,
      color: AppColors.familySuccess,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        leading: AppBackButton(onTap: () async => Navigator.of(context).pop()),
        title: Text(
          'Family Members',
          style: AppStyles.h1.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Add new family member
            },
            icon: const Icon(Icons.person_add, color: AppColors.familyPrimary),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.all(AppSpacing.spacing2xl),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.familyPrimary.withValues(alpha: 0.1),
                      AppColors.familySecondary.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                  border: Border.all(
                    color: AppColors.familyPrimary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.spacingMd),
                      decoration: BoxDecoration(
                        color: AppColors.familyPrimary,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusRound,
                        ),
                      ),
                      child: const Icon(
                        Icons.family_restroom,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.spacingLg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Family Network',
                            style: AppStyles.h2.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.spacingXs),
                          Text(
                            '${_familyMembers.where((member) => member.isLinked).length} of ${_familyMembers.length} members linked',
                            style: AppStyles.p1.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.spacing3xl),

              // Family members list
              Expanded(
                child: ListView.builder(
                  itemCount: _familyMembers.length,
                  itemBuilder: (context, index) {
                    final member = _familyMembers[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: AppSpacing.spacingMd,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bgSecondary,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusNormal,
                        ),
                        border: Border.all(
                          color: member.isLinked
                              ? member.color.withValues(alpha: 0.3)
                              : AppColors.borderDisabled,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(
                          AppSpacing.spacingMd,
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: member.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusRound,
                            ),
                            border: Border.all(
                              color: member.color.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              member.avatar,
                              style: const TextStyle(fontSize: 24),
                            ),
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
                          style: AppStyles.label1.copyWith(
                            color: AppColors.textSecondary,
                          ),
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
                                    ? AppColors.familySuccess.withValues(
                                        alpha: 0.1,
                                      )
                                    : AppColors.familyWarning.withValues(
                                        alpha: 0.1,
                                      ),
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMinimal,
                                ),
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
                            const SizedBox(width: AppSpacing.spacingSm),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                          ],
                        ),
                        onTap: () {
                          // TODO: Navigate to member details
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.spacingLg),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Add Member',
                      onPressed: () async {
                        getIt<RouteHelper>().showAddMemberScreen();
                      },
                      buttonType: ButtonType.secondary,
                      leadingIcon: Icons.person_add,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spacingMd),
                  Expanded(
                    child: AppButton(
                      text: 'View Tree',
                      onPressed: () async {
                        getIt<RouteHelper>().showFamilyTreeScreen();
                      },
                      leadingIcon: Icons.account_tree,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
