import 'package:flutter/material.dart';

import '../../core/enum/button_type.dart';
import '../../core/style_guide/style_guide.dart';
import '../../core/widgets/widgets.dart';
import '../../dependency_manager/dependency_manager.dart';
import '../../router/route_helper.dart';

class FamilyTreeScreen extends StatefulWidget {
  const FamilyTreeScreen({super.key});

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppAppBar(
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        titleWidget: const Text('Family Tree', style: AppStyles.h3),
        centerTitle: true,
        onLeadingIconPressed: () => getIt<RouteHelper>().pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingComfortable,
                    horizontal: AppSpacing.paddingCompressed,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.treeNode,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                    border: Border.all(color: AppColors.treeLine),
                  ),
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Grandparents row
                          Row(
                            spacing: AppSpacing.spacingLg,
                            children: [
                              _buildTreeNode(
                                '👴',
                                'Grandpa',
                                "Father's Father",
                              ),
                              _buildTreeNode(
                                '👵',
                                'Grandma',
                                "Father's Mother",
                              ),
                              _buildTreeNode(
                                '👴',
                                'Grandpa',
                                "Mother's Father",
                              ),
                              _buildTreeNode(
                                '👵',
                                'Grandma',
                                "Mother's Mother",
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.spacingLg),

                          // Connection lines
                          Container(
                            height: 20,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: AppColors.treeLine),
                                right: BorderSide(color: AppColors.treeLine),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.spacingLg),

                          // Parents row
                          Row(
                            spacing: AppSpacing.spacingLg,
                            children: [
                              _buildTreeNode(
                                '👨‍🦰',
                                'Dad',
                                'Father',
                                isSelected: true,
                              ),
                              _buildTreeNode(
                                '👩‍🦰',
                                'Mom',
                                'Mother',
                                isSelected: true,
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.spacingLg),

                          // Connection lines
                          Container(
                            height: 20,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: AppColors.treeLine),
                                right: BorderSide(color: AppColors.treeLine),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.spacingLg),

                          // Current user and siblings
                          Row(
                            spacing: AppSpacing.spacingLg,
                            children: [
                              _buildTreeNode('👦', 'Brother', 'Sibling'),
                              _buildTreeNode(
                                '👤',
                                'You',
                                'Current User',
                                isSelected: true,
                                isHighlighted: true,
                              ),
                              _buildTreeNode('👧', 'Sister', 'Sibling'),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.spacingLg),

                          // Connection lines
                          Container(
                            height: 20,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: AppColors.treeLine),
                                right: BorderSide(color: AppColors.treeLine),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.spacingLg),

                          // Children row (if any)
                          Row(
                            spacing: AppSpacing.spacingLg,
                            children: [
                              _buildTreeNode(
                                '👶',
                                'Child',
                                'Your Child',
                                isFuture: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.spacingLg),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Add Member',
                      onPressed: () async {},
                      buttonType: ButtonType.secondary,
                      leadingIcon: Icons.person_add,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spacingMd),
                  Expanded(
                    child: AppButton(
                      text: 'Export Tree',
                      onPressed: () async {},
                      leadingIcon: Icons.download,
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

  Widget _buildTreeNode(
    String emoji,
    String name,
    String relation, {
    bool isSelected = false,
    bool isHighlighted = false,
    bool isFuture = false,
  }) {
    final Color nodeColor = isHighlighted
        ? AppColors.familyPrimary
        : isSelected
        ? AppColors.treeNodeSelected
        : AppColors.bgSecondary;

    final Color borderColor = isHighlighted
        ? AppColors.familyPrimary
        : isSelected
        ? AppColors.familyPrimary.withValues(alpha: 0.5)
        : AppColors.treeLine;

    final Color textColor = isHighlighted
        ? AppColors.white
        : AppColors.textPrimary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacingMd),
      decoration: BoxDecoration(
        color: nodeColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        border: Border.all(color: borderColor, width: isHighlighted ? 2 : 1),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: AppColors.familyPrimary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: AppSpacing.spacingXs),
          Text(
            name,
            style: AppStyles.label1.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            relation,
            style: AppStyles.label2.copyWith(
              color: isHighlighted
                  ? AppColors.white.withValues(alpha: 0.8)
                  : AppColors.textSecondary,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          if (isFuture) ...[
            const SizedBox(height: AppSpacing.spacingXs),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacingXs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.familyWarning.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMinimal),
              ),
              child: Text(
                'Future',
                style: AppStyles.label2.copyWith(
                  color: AppColors.familyWarning,
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
