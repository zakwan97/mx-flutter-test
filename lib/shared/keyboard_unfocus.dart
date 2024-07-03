import 'package:flutter/material.dart';

class KeyboardUnfocusFunction extends StatelessWidget {
  final Widget child;
  const KeyboardUnfocusFunction({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
