part of 'widgets.dart';

class OtpInputField extends StatefulWidget {
  const OtpInputField({
    required this.length,
    required this.onCompleted,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.textStyle,
    this.fieldWidth = 45.0,
    this.fieldHeight = 55.0,
    this.spacing = 8.0,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.backgroundColor,
    this.cursorColor,
    this.showPasteButton = true,
    super.key,
  });

  final int length;
  final Function(String) onCompleted;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle;
  final double fieldWidth;
  final double fieldHeight;
  final double spacing;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final Color? cursorColor;
  final bool showPasteButton;

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.length, (index) => FocusNode());

    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNodes[0].requestFocus();
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value) {
    widget.onChanged?.call(value);

    if (value.length == widget.length) {
      widget.onCompleted(value);
    }
  }

  Future<void> _handlePaste() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData?.text != null) {
        final pastedText = clipboardData!.text!;
        final digits = pastedText.replaceAll(RegExp('[^0-9]'), '');

        if (digits.isNotEmpty) {
          final otp = digits.substring(
            0,
            digits.length > widget.length ? widget.length : digits.length,
          );

          for (final controller in _controllers) {
            controller.clear();
          }

          for (int i = 0; i < otp.length && i < widget.length; i++) {
            _controllers[i].text = otp[i];
          }

          _onOtpChanged(otp);

          if (otp.length < widget.length) {
            _focusNodes[otp.length].requestFocus();
          } else {
            FocusScope.of(context).unfocus();
          }
        }
      }
    } on Exception catch (_) {}
  }

  void _onFieldChanged(String value, int index) {
    if (value.length == 1) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final newOtp = StringBuffer();
    for (final controller in _controllers) {
      newOtp.write(controller.text);
    }
    _onOtpChanged(newOtp.toString());
  }

  void _onFieldTap(int index) {
    _controllers[index].selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controllers[index].text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: widget.spacing,
          children: List.generate(
            widget.length,
            (index) => Expanded(child: _buildOtpField(index)),
          ),
        ),
        if (widget.showPasteButton) ...[
          const SizedBox(height: AppSpacing.spacingXs),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _handlePaste,
              icon: const Icon(
                Icons.paste,
                size: 14,
                color: AppColors.familyPrimary,
              ),
              label: Text(
                'Paste OTP',
                style: AppStyles.label2.copyWith(
                  color: AppColors.familyPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacingSm,
                ),
                minimumSize: const Size(0, 32),
                backgroundColor: AppColors.familyPrimary.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOtpField(int index) {
    final isFocused = _focusNodes[index].hasFocus;

    return Container(
      height: widget.fieldHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.bgTertiary,
        borderRadius: BorderRadius.circular(
          widget.borderRadius ?? AppSpacing.radiusNormal,
        ),
        border: Border.all(
          color: isFocused
              ? (widget.focusedBorderColor ?? AppColors.familyPrimary)
              : (widget.borderColor ?? AppColors.borderDisabled),
          width: isFocused ? 2 : 1,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: (widget.focusedBorderColor ?? AppColors.familyPrimary)
                      .withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: widget.keyboardType,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: (widget.textStyle ?? AppStyles.h2).copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: widget.cursorColor ?? AppColors.familyPrimary,
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          counterText: '',
          filled: false,
        ),
        onChanged: (value) => _onFieldChanged(value, index),
        onTap: () => _onFieldTap(index),
        onSubmitted: (_) {
          if (index < widget.length - 1) {
            _focusNodes[index + 1].requestFocus();
          } else {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}
