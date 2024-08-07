import 'package:flutter/material.dart';
import 'package:sight_companion/models/physical_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:sight_companion/models/models.dart';

/// button that acts as the focus node for keyboard input
class KeyboardFocus extends StatelessWidget {
  const KeyboardFocus({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode =
        Provider.of<InputState>(context, listen: false).focusNode;
    return Stack(
      alignment: Alignment.center,
      children: [
        RawKeyboardListener(
          focusNode: focusNode,
          onKey: (event) {
            MyPhysicalKeyboard.handleKeyEvent(context, event);
          },
          child: Container(),
        ),
        IconButton(
            onPressed: () {
              MyPhysicalKeyboard.keyboardButtonPressed(context);
            },
            icon: const Icon(Icons.keyboard),
            tooltip: "Use physical keyboard"),
      ],
    );
  }
}
