import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/models/family_member_display_model.dart';
import '../../../core/models/family_model/family_model.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/shared_preferences_helper.dart';
import '../../../core/widgets/widgets.dart';
import '../../../dependency_manager/dependency_manager.dart';
import '../store/dashboard_store.dart';
import '../widgets/family_head_widget.dart';
import '../widgets/member_tile.dart';
import '../widgets/no_member_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final DashboardStore _dashboardStore;
  late final SharedPreferencesHelper _sharedPreferencesHelper;
  late final String _mobileNumber;

  @override
  void initState() {
    super.initState();
    _dashboardStore = context.read<DashboardStore>();
    _sharedPreferencesHelper = getIt<SharedPreferencesHelper>();
    _mobileNumber = _sharedPreferencesHelper.getMobileNumber();
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

  Color _getMemberColor(int index) {
    final colors = [
      AppColors.familyPrimary,
      AppColors.familySecondary,
      AppColors.familyAccent,
      AppColors.familySuccess,
      AppColors.familyWarning,
    ];
    return colors[index % colors.length];
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

  List<FamilyMemberDisplay> _getFamilyMembers(FamilyModel familyModel) {
    final allMembers = <FamilyMemberDisplay>[];

    for (int i = 0; i < familyModel.members.length; i++) {
      final member = familyModel.members[i];
      allMembers.add(
        FamilyMemberDisplay(
          name: _getMemberName(member),
          relation: member.relationWithFamilyHead ?? 'Member',
          avatar: _getMemberAvatar(member.gender),
          isLinked: member.phoneNumber?.isNotEmpty ?? false,
          color: _getMemberColor(i),
          member: member,
          photo: member.photo,
          isYou: member.phoneNumber == _mobileNumber,
        ),
      );
    }

    return allMembers;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final familyModel = _dashboardStore.familyModel;

        if (familyModel == null) {
          return const Center(child: AppLoader());
        }

        final allMembers = _getFamilyMembers(familyModel);
        final isFamilyHead = _dashboardStore.isFamilyHead;

        return Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FamilyHeadWidget(
                genderIcon: _getMemberAvatar(familyModel.head.gender),
                name: _getHeadName(familyModel.head),
                isFamilyHeadLoggedIn: isFamilyHead,
                allMemberCount: allMembers.length,
              ),
              const SizedBox(height: AppSpacing.spacing3xl),
              Row(
                children: [
                  const Icon(
                    Icons.people,
                    color: AppColors.familyPrimary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.spacingSm),
                  Text(
                    'Members',
                    style: AppStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${allMembers.where((member) => member.isLinked).length}/${allMembers.length} linked',
                    style: AppStyles.label1.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.spacingLg),
              Expanded(
                child: allMembers.isEmpty
                    ? const NoMemberWidget()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: allMembers.length,
                        itemBuilder: (context, index) => MemberTile(
                          member: allMembers[index],
                          isFamilyHead: isFamilyHead,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
