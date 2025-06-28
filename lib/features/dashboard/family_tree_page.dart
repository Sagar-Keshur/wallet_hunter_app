import 'package:flutter/material.dart';

import '../../core/enum/button_type.dart';
import '../../core/style_guide/style_guide.dart';
import '../../core/widgets/widgets.dart';

class FamilyTreePage extends StatefulWidget {
  const FamilyTreePage({super.key});

  @override
  State<FamilyTreePage> createState() => _FamilyTreePageState();
}

class _FamilyTreePageState extends State<FamilyTreePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        leading: AppBackButton(onTap: () async => Navigator.of(context).pop()),
        title: Text(
          'Family Tree',
          style: AppStyles.h1.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Edit tree
            },
            icon: const Icon(Icons.edit, color: AppColors.familyPrimary),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.spacing2xl),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.treeNodeSelected.withValues(alpha: 0.3),
                      AppColors.familyPrimary.withValues(alpha: 0.1),
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
                        Icons.account_tree,
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
                            'Your Family Tree',
                            style: AppStyles.h2.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.spacingXs),
                          Text(
                            'Visualize your family connections',
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

              // Tree visualization
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.spacing2xl),
                  decoration: BoxDecoration(
                    color: AppColors.treeNode,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                    border: Border.all(color: AppColors.treeLine),
                  ),
                  child: Column(
                    children: [
                      // Grandparents row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTreeNode('👴', 'Grandpa', "Father's Father"),
                          _buildTreeNode('👵', 'Grandma', "Father's Mother"),
                          _buildTreeNode('👴', 'Grandpa', "Mother's Father"),
                          _buildTreeNode('👵', 'Grandma', "Mother's Mother"),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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

              const SizedBox(height: AppSpacing.spacingLg),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Add Member',
                      onPressed: () async {
                        // TODO: Add new family member
                      },
                      buttonType: ButtonType.secondary,
                      leadingIcon: Icons.person_add,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spacingMd),
                  Expanded(
                    child: AppButton(
                      text: 'Export Tree',
                      onPressed: () async {
                        // TODO: Export family tree
                      },
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
