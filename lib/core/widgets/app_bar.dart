part of 'widgets.dart';

class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AppAppBar({
    this.title = '',
    this.titleWidget,
    this.leadingIcon,
    this.onLeadingIconPressed,
    this.actions = const [],
    this.centerTitle = false,
    super.key,
  });

  final String title;
  final Widget? titleWidget;
  final IconData? leadingIcon;
  final void Function()? onLeadingIconPressed;
  final List<Widget> actions;
  final bool centerTitle;

  @override
  State<AppAppBar> createState() => _AppAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppAppBarState extends State<AppAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: widget.centerTitle,
      title:
          widget.titleWidget ??
          (widget.title.isNotEmpty
              ? Text(widget.title, style: AppStyles.h7)
              : null),
      leading: widget.leadingIcon != null
          ? IconButton(
              icon: Icon(widget.leadingIcon, color: AppColors.iconsSecondary),
              onPressed: widget.onLeadingIconPressed,
            )
          : null,
      titleSpacing: 0,
      actions: [
        ...widget.actions,
        const SizedBox(width: AppSpacing.paddingMargin),
      ],
    );
  }
}
