import 'dart:ui';

import 'family_model/family_model.dart';

class FamilyMemberDisplay {
  FamilyMemberDisplay({
    required this.name,
    required this.relation,
    required this.avatar,
    required this.isLinked,
    required this.color,
    required this.member,
    this.isYou = false,
    this.photo,
  });

  final String name;
  final String relation;
  final String avatar;
  final bool isLinked;
  final Color color;
  final MemberModel member;
  final bool isYou;
  final String? photo;
}
