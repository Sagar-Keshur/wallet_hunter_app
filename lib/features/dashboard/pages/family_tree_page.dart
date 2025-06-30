import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/models/family_model/family_model.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/context_extension.dart';
import '../../../core/widgets/widgets.dart';
import '../store/dashboard_store.dart';

class FamilyTreeNode {
  FamilyTreeNode({
    required this.name,
    required this.relation,
    required this.avatar,
    required this.isHead,
    required this.isCurrentUser,
    required this.member,
  });

  final String name;
  final String relation;
  final String avatar;
  final bool isHead;
  final bool isCurrentUser;
  final dynamic member; // Can be HeadMemberModel or MemberModel
}

class FamilyTreeScreen extends StatefulWidget {
  const FamilyTreeScreen({super.key});

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  late final DashboardStore _dashboardStore;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _dashboardStore = context.read<DashboardStore>();
  }

  String _getMemberAvatar(String? gender) {
    switch (gender?.toLowerCase()) {
      case 'male':
        return '👨';
      case 'female':
        return '👩';
      default:
        return '👤';
    }
  }

  String _getMemberName(MemberModel member) {
    final parts = <String>[];
    if (member.firstName?.isNotEmpty ?? false) {
      parts.add(member.firstName!);
    }
    if (member.middleName?.isNotEmpty ?? false) {
      parts.add(member.middleName!);
    }
    if (member.lastName?.isNotEmpty ?? false) {
      parts.add(member.lastName!);
    }
    return parts.isEmpty ? 'Unknown' : parts.join(' ');
  }

  String _getHeadName(HeadMemberModel head) {
    return head.name?.isNotEmpty ?? false ? head.name! : 'Family Head';
  }

  List<FamilyTreeNode> _getFamilyTreeData(FamilyModel familyModel) {
    final treeData = <FamilyTreeNode>[
      FamilyTreeNode(
        name: _getHeadName(familyModel.head),
        relation: 'Family Head',
        avatar: _getMemberAvatar(familyModel.head.gender),
        isHead: true,
        isCurrentUser: true,
        member: familyModel.head,
      ),
    ];

    // Add other family members
    for (final member in familyModel.members) {
      treeData.add(
        FamilyTreeNode(
          name: _getMemberName(member),
          relation: member.relationWithFamilyHead ?? 'Member',
          avatar: _getMemberAvatar(member.gender),
          isHead: false,
          isCurrentUser: false,
          member: member,
        ),
      );
    }

    return treeData;
  }

  List<List<FamilyTreeNode>> _organizeFamilyTree(List<FamilyTreeNode> members) {
    final organizedTree = <List<FamilyTreeNode>>[];

    // Find family head (current user)
    final familyHead = members.firstWhere((member) => member.isHead);

    // Level 1: Family Head (Current User)
    organizedTree.add([familyHead]);

    // Level 2: Direct family members (parents, spouse, children)
    final directMembers = members.where((member) {
      return !member.isHead &&
          (member.relation.toLowerCase().contains('parent') ||
              member.relation.toLowerCase().contains('spouse') ||
              member.relation.toLowerCase().contains('child') ||
              member.relation.toLowerCase().contains('father') ||
              member.relation.toLowerCase().contains('mother'));
    }).toList();

    if (directMembers.isNotEmpty) {
      organizedTree.add(directMembers);
    }

    // Level 3: Extended family (siblings, cousins, etc.)
    final extendedMembers = members
        .where((member) => !member.isHead && !directMembers.contains(member))
        .toList();

    if (extendedMembers.isNotEmpty) {
      organizedTree.add(extendedMembers);
    }

    return organizedTree;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final familyModel = _dashboardStore.familyModel;

        if (familyModel == null) {
          return const Center(child: AppLoader());
        }

        final allMembers = _getFamilyTreeData(familyModel);
        final organizedTree = _organizeFamilyTree(allMembers);

        if (allMembers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_tree_outlined,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: AppSpacing.spacingLg),
                Text(
                  'No family members yet',
                  style: AppStyles.h2.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.spacingSm),
                Text(
                  'Add family members to see your family tree',
                  style: AppStyles.p1.copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingLg),
                  decoration: BoxDecoration(
                    color: AppColors.bgSecondary,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusNormal,
                    ),
                    border: Border.all(color: AppColors.borderDisabled),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.spacingSm),
                        decoration: BoxDecoration(
                          color: AppColors.familyPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusRound,
                          ),
                        ),
                        child: const Icon(
                          Icons.account_tree,
                          color: AppColors.familyPrimary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spacingLg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Family Tree',
                              style: AppStyles.h2.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${allMembers.length} family members',
                              style: AppStyles.label1.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spacingXs),
                      AppButton(
                        text: 'Share',
                        onPressed: onShareFamilyTree,
                        isLoading: _dashboardStore.isFamilyTreeExporting,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingLg),
                // Family Tree
                Expanded(
                  child: Screenshot(
                    controller: screenshotController,
                    child: Container(
                      width: context.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.paddingComfortable,
                        horizontal: AppSpacing.paddingCompressed,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.treeNode,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusRound,
                        ),
                        border: Border.all(color: AppColors.treeLine),
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (
                                  int levelIndex = 0;
                                  levelIndex < organizedTree.length;
                                  levelIndex++
                                ) ...[
                                  if (levelIndex > 0) ...[
                                    const SizedBox(
                                      height: AppSpacing.spacingLg,
                                    ),
                                    // Connection lines
                                    Container(
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: AppColors.treeLine,
                                          ),
                                          right: BorderSide(
                                            color: AppColors.treeLine,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppSpacing.spacingLg,
                                    ),
                                  ],
                                  // Family members row
                                  Row(
                                    spacing: AppSpacing.spacingLg,
                                    children: organizedTree[levelIndex].map((
                                      member,
                                    ) {
                                      return _buildTreeNode(
                                        member.avatar,
                                        member.name,
                                        member.relation,
                                        isSelected: member.isHead,
                                        isHighlighted: member.isCurrentUser,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> onShareFamilyTree() async {
    _dashboardStore.isFamilyTreeExporting = true;
    final file = await screenshotController.capture();
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/family_tree.png').create();
    await imagePath.writeAsBytes(file!);
    final ShareParams shareParams = ShareParams(
      files: [XFile(imagePath.path)],
      text: 'Family Tree',
    );
    await SharePlus.instance.share(shareParams);
    _dashboardStore.isFamilyTreeExporting = false;
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
      width: 120,
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
          Stack(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              if (isHighlighted)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMinimal,
                      ),
                      border: Border.all(color: AppColors.familyPrimary),
                    ),
                    child: Text(
                      'YOU',
                      style: AppStyles.label2.copyWith(
                        color: AppColors.familyPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
            ],
          ),
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
