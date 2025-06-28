part of 'widgets.dart';

class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AppAppBar({
    this.title = '',
    this.titleWidget,
    this.leadingIcon,
    this.onLeadingIconPressed,
    this.actions = const [],
    super.key,
  });

  final String title;
  final Widget? titleWidget;
  final IconData? leadingIcon;
  final void Function()? onLeadingIconPressed;
  final List<Widget> actions;

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
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      title: widget.titleWidget ??
          (widget.title.isNotEmpty
              ? Text(
                  widget.title,
                  style: AppStyles.h7,
                )
              : null),
      leading: widget.leadingIcon != null
          ? IconButton(
              icon: Icon(
                widget.leadingIcon,
                color: AppColors.iconsSecondary,
              ),
              onPressed: widget.onLeadingIconPressed,
            )
          : null,
      actions: [
        ...widget.actions,
        const SizedBox(width: AppSpacing.paddingComfortable),
      ],
    );
  }
}
