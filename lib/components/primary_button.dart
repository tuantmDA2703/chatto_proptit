import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  Widget? child;
  bool isActive;
  Color? colorActive;
  Color? colorInActive;
  VoidCallback? onPressed;
  VoidCallback? onLongPress;

  late ButtonStyle buttonStyle;
  BorderRadius? borderRadius;
  BorderSide? side;

  PrimaryButton({
    Key? key,
    this.child,
    this.isActive = true,
    this.colorActive,
    this.colorInActive,
    required this.onPressed,
    this.onLongPress,
    this.borderRadius,
    this.side,
    ButtonStyle? buttonStyle,
  }) : super(key: key) {
    this.buttonStyle = buttonStyle ??
        ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return colorInActive;
              }
              return colorActive;
            },
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              side: side ?? BorderSide.none,
              borderRadius: borderRadius ?? BorderRadius.zero,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? onPressed : null,
      onLongPress: onLongPress,
      style: buttonStyle,
      child: child,
    );
  }
}
