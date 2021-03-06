import 'package:flutter/cupertino.dart';
import 'package:flutterapp/utils/theme_utils.dart';
import 'package:keyboard_actions/keyboard_action.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

class Utils {
  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: List.generate(
          list.length,
          (i) => KeyboardAction(
                focusNode: list[i],
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () => node.unfocus(),
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: const Text('关闭'),
                      ),
                    );
                  },
                ],
              )),
    );
  }
}
