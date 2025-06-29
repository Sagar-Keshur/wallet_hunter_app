part of 'widgets.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.controller,
    this.label,
    this.errorText,
    this.leadingIcon,
    this.trailingIcon,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onLeadingIconPressed,
    this.onTrailingIconPressed,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.isDisabled = false,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.autofocus = false,
    this.isMessageField = false,
    this.firstLetterCapitalized = true,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.readOnly = false,
    this.showHintOnTap = true,
    this.fillColor,
    this.hasBorder = true,
    this.validator,
    super.key,
  });

  final String? label;
  final String? errorText;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final void Function()? onLeadingIconPressed;
  final void Function()? onTrailingIconPressed;
  final void Function()? onTap;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isDisabled;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final bool autofocus;
  final bool isMessageField;
  final bool firstLetterCapitalized;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool showHintOnTap;
  final Color? fillColor;
  final bool hasBorder;
  final String? Function(String?)? validator;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final AppTextFieldStore store = AppTextFieldStore();
  late final FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(_updateStore);
    super.initState();
  }

  void _updateStore() {
    store
      ..hasFocus = focusNode.hasFocus
      ..hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Text(widget.label!, style: AppStyles.p1),
          // TODO(pb): Add spacing from primitive spacings
          const SizedBox(height: 6),
        ],
        Observer(
          builder: (_) {
            return TextFormField(
              controller: widget.controller,
              focusNode: focusNode,
              inputFormatters: widget.inputFormatters,
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              minLines: widget.isMessageField ? 1 : null,
              maxLines: widget.isMessageField ? 4 : widget.maxLines,
              textCapitalization: widget.firstLetterCapitalized
                  ? TextCapitalization.sentences
                  : TextCapitalization.none,
              onChanged: (val) => widget.onChanged?.call(val),
              onFieldSubmitted: (val) => widget.onSubmitted?.call(val),
              autofillHints: widget.autofillHints,
              onTap: widget.onTap,
              autofocus: widget.autofocus,
              readOnly: widget.readOnly,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: store.hasFocus
                    ? widget.showHintOnTap
                          ? widget.hintText
                          : null
                    : widget.hintText,
                hintStyle: AppStyles.label1.copyWith(
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: widget.fillColor ?? AppColors.bgTertiary,
                focusedErrorBorder: _border(AppColors.borderError),
                errorBorder: _border(AppColors.borderError),
                enabledBorder: _border(AppColors.borderDisabled),
                focusedBorder: _border(AppColors.borderActive),
                disabledBorder: _border(AppColors.borderDisabled),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),

                prefixIcon: (widget.leadingIcon != null
                    ? IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          widget.leadingIcon,
                          color: store.hasFocus
                              ? AppColors.textPrimary.withAlpha(150)
                              : AppColors.textSecondary,
                        ),
                        onPressed: widget.onLeadingIconPressed,
                      )
                    : null),
                suffixIcon:
                    widget.trailingIcon != null ||
                        widget.errorText != null && widget.errorText!.isNotEmpty
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.trailingIcon != null)
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: widget.onTrailingIconPressed,
                              borderRadius: BorderRadius.circular(100),
                              child: Icon(
                                widget.trailingIcon,
                                color: store.hasFocus
                                    ? AppColors.textPrimary.withAlpha(150)
                                    : AppColors.textSecondary,
                              ),
                            ),
                          if (widget.errorText != null &&
                              widget.errorText!.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            const Icon(Icons.error, color: AppColors.textError),
                          ],
                          const SizedBox(width: 12),
                        ],
                      )
                    : null,
              ),
              style: AppStyles.label1.copyWith(color: AppColors.textPrimary),
              cursorColor: AppColors.textPrimary,
              enabled: !widget.isDisabled,
            );
          },
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.spacingXs),
          Text(
            widget.errorText!,
            style: AppStyles.label1.copyWith(color: AppColors.textError),
          ),
        ],
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: widget.hasBorder
          ? BorderSide(
              color: widget.errorText != null && widget.errorText!.isNotEmpty
                  ? AppColors.textError
                  : AppColors.textSecondary,
            )
          : BorderSide.none,
    );
  }
}
