

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/common.dart';
import 'package:flutterapp/res/styles.dart';
import 'package:flutterapp/utils/utils.dart';
import 'package:flutterapp/widgets/app_bar.dart';
import 'package:flutterapp/widgets/my_scroll_view.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //创建两个 controller 监听 输入框的内容
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

  //创建焦点对象 来控制输入发键盘的显示和隐藏
  FocusNode _nodeText_1 = FocusNode();
  FocusNode _nodeText_2 = FocusNode();

  bool _clickAble = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化 Controller
    _nameController.addListener(_verify);
    _passWordController.addListener(_verify);
  }

  void _verify() {
    var _name = _nameController.text;
    var _passWord = _passWordController.text;
    var clickAble = true;

    if (_name.isEmpty && _name.length < 11) {
      clickAble = false;
    }
    if (_passWord.isEmpty && _passWord.length < 6) {
      clickAble = false;
    }

    if (_clickAble != clickAble) {
      //更新页面
      setState(() {
        _clickAble = clickAble;
      });
    }
  }

  /**
   * 请求接口请求成功后跳转到首页
   */
  void _login() {
    SpUtil.putString(Constant.phone, _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: '验证码登陆',
        onPressed: () {
          //跳转到验证码登陆页面
        },
      ),
      body: MyScrollView(
        keyboardConfig:
            Utils.getKeyboardActionsConfig(context, [_nodeText_1, _nodeText_1]),
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody,
      ),
    );
  }
}

get _buildBody => [
  const Text(
    '密码登录',
    style: TextStyles.textBold26,
  ),
];
