import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/widgets/HeadIconWidget.dart';
import 'package:yiqu/widgets/LineTextInputWidget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  // String _account, _password;

  void submitLoginForm() {
    //保存当前状态的值，即前面onSaved里执行的内容
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      // TODO:提交给数据库验证
      // print("account: $_account");
      // print("password: $_password");
    } else {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text("正在登陆..."),
      //   duration: Duration(seconds: 2),
      // ));
    }
  }

  // TODO: 连接数据库
  /// #### 验证账号是否正确
  /// 验证无误则返回 `true`，验证失败则返回 `false`
  bool validateAccount(String value) {
    if (value.isEmpty) {
      // return false;
    }
    return true;
  }

  // TODO: 连接数据库
  /// #### 验证密码是否正确
  bool validatePassword(String value) {
    if (value.isEmpty) {
      // return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 32.0, right: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            HeadIconWidget(
              user: User.boyUser,
            ),

            // 输入表单
            Form(
              key: _loginFormKey,
              child: Column(
                children: <Widget>[
                  // 输入账号文本框
                  LineTextInputWidget(
                    hintText: "输入账号",
                    errorText: "账号不能为空",
                    maxLength: 22,
                    validator: validateAccount,
                    icon: Icon(Icons.account_circle, color: AppTheme.mainDark),
                  ),

                  // 间隔
                  SizedBox(height: 8.0),

                  // 输入密码文本框
                  LineTextInputWidget(
                    icon: Icon(Icons.lock, color: AppTheme.mainDark),
                    hintText: "输入密码",
                    errorText: "密码不能为空",
                    maxLength: 16,
                    validator: validatePassword,
                    isPassword: true,
                  ),

                  // 注册新用户和忘记密码
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            "注册成为新用户",
                            style: AppTheme.titleTextStyle.copyWith(
                              color: AppTheme.mainBlue,
                            ),
                          ),

                          // 进入注册页面
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (BuildContext context) => RegisterPage();
                            // ));
                          },
                        ),
                        InkWell(
                          child: Text(
                            "忘记密码?",
                            style: AppTheme.titleTextStyle.copyWith(
                              color: AppTheme.mainBlue,
                            ),
                          ),

                          // 进入忘记密码页面
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (BuildContext context) => ForgetPassword();
                            // ));
                          },
                        ),
                      ],
                    ),
                  ),

                  // 登录按钮
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        '登录',
                        style: AppTheme.titleTextStyle.copyWith(
                          color: AppTheme.mainBackground,
                        ),
                      ),
                      onPressed: submitLoginForm,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 8.0),
                          blurRadius: 14.0,
                          color: AppTheme.blueButtonShadow,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 其它方式登录

            // 其它方式登录的图标
            Padding(
              padding: EdgeInsets.only(top: 100.0, bottom: 20.0),
              child: Text(
                "—  其它方式登录  —",
                style: AppTheme.inactiveTextStyle.copyWith(fontSize: 14.0),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Image(
                    image: AssetImage("assets/images/login_by_alipay.png"),
                    width: 42.0,
                  ),
                ),
                InkWell(
                  child: Image(
                    image: AssetImage("assets/images/login_by_qq.png"),
                    width: 36.0,
                  ),
                ),
                InkWell(
                  child: Image(
                    image: AssetImage("assets/images/login_by_wechat.png"),
                    width: 46.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
