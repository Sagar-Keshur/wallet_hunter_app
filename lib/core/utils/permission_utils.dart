// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/app_permission_dialog.dart';

Future<bool> checkAndRequestPermission(
  BuildContext context, {
  required Permission permission,
  required String permissionDescription,
  required String permissionType,
  required String permissionTitle,
}) async {
  final permissionStatus = await permission.request();
  if (permissionStatus.isGranted || permissionStatus.isLimited) {
    return true;
  } else {
    await showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => PermissionDialog(
        permissionType: permissionType,
        title: permissionTitle,
        description: permissionDescription,
      ),
    );
    return false;
  }
}
