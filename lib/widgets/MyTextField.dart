import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/res/colors.dart';
import 'package:flutterapp/res/dimens.dart';
import 'package:flutterapp/res/gaps.dart';
import 'package:flutterapp/widgets/load_image.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;
  final Future<bool> Function() getVCode;
  final String keyName;
  final int maxLength;

  MyTextField(
      {Key key,
      this.controller,
      this.autoFocus: false,
      this.maxLength: 16,
      this.keyboardType: TextInputType.text,
      this.hintText: '',
      this.focusNode,
      this.isInputPwd: false,
      this.getVCode,
      this.keyName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyTextFiedldState();
}

class _MyTextFiedldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  int _currentSecond;

  StreamSubscription _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isShowDelete = widget.controller.text.isEmpty;
    widget.controller.addListener(isEmpty);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    widget.controller?.removeListener(isEmpty);
  }

  Future _getVCode() async {
    bool isSuccess = await widget.getVCode();
    if (isSuccess != null && isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });

      _subscription = Stream.periodic(Duration(seconds: 1), (i) => i)
          .take(_second)
          .listen((i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
    }
  }

  void isEmpty() {
    bool isEmpty = widget.controller.text.isEmpty;

    if (isEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    return Stack(alignment: Alignment.centerRight, children: <Widget>[
      TextField(
        focusNode: widget.focusNode,
        maxLength: widget.maxLength,
        obscureText: widget.isInputPwd ? !_isShowPwd : false,
        autofocus: widget.autoFocus,
        controller: widget.controller,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType,
        inputFormatters: (widget.keyboardType == TextInputType.number ||
                widget.keyboardType == TextInputType.phone)
            ? [WhitelistingTextInputFormatter(RegExp('[0-9]'))]
            : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            hintText: widget.hintText,
            counterText: '',
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: themeData.primaryColor, width: 0.8)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).dividerTheme.color, width: 0.8))),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _isShowDelete
              ? Gaps.empty
              : Semantics(
                  label: '清空',
                  hint: '清空输入框',
                  child: GestureDetector(
                    child: LoadAssetImage(
                      'login/qyg_shop_icon_delete',
                      key: Key('${widget.keyName}_delete'),
                      width: 18.0,
                      height: 40.0,
                    ),
                    onTap: () => widget.controller.text = '',
                  ),
                ),
          !widget.isInputPwd ? Gaps.empty : Gaps.hGap15,
          !widget.isInputPwd
              ? Gaps.empty
              : Semantics(
                  label: '密码可见开关',
                  hint: '密码是否可见',
                  child: GestureDetector(
                    child: LoadAssetImage(
                      _isShowPwd
                          ? 'login/qyg_shop_icon_display'
                          : 'login/qyg_shop_icon_hide',
                      key: Key('${widget.keyName}_showPwd'),
                      width: 18.0,
                      height: 40.0,
                    ),
                    onTap: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                  )),
          widget.getVCode == null ? Gaps.empty : Gaps.hGap15,
          widget.getVCode == null
              ? Gaps.empty
              : Theme(
                  data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: 26.0,
                    minWidth: 76.0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )),
                  child: FlatButton(
                    onPressed: _clickable ? _getVCode : null,
                    textColor: themeData.primaryColor,
                    color: Colors.transparent,
                    disabledTextColor:
                        isDark ? Colours.dark_text : Colors.white,
                    disabledColor:
                        isDark ? Colours.dark_text_gray : Colours.text_gray_c,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                      color: _clickable
                          ? themeData.primaryColor
                          : Colors.transparent,
                      width: 0.8,
                    )),
                    child: Text(
                      _clickable ? "获取验证码" : '($_currentSecond s)',
                      style: TextStyle(fontSize: Dimens.font_sp12),
                    ),
                  ),
                )
        ],
      )
    ]);
  }
}
