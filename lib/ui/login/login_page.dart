import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/db/database.dart';
import 'package:flutter_hoo/db/use.dart';
import 'package:flutter_hoo/style/theme/strings.dart';
import 'package:flutter_hoo/ui/main/main_page.dart';
import 'package:flutter_hoo/widget/my_button.dart';
import 'package:flutter_hoo/widget/my_textfield.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String account = "";
  String pwd = "";
  bool isButtonEnable = false;

  @override
  void initState() {
    super.initState();

    isButtonEnable = account.isNotEmpty && pwd.isNotEmpty;
  }

  void _onTextChange() {
    bool currentState = account.isNotEmpty && pwd.isNotEmpty;
    if (currentState != isButtonEnable) {
      setState(() {
        isButtonEnable = currentState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        56.0 -
        MediaQuery.of(context).padding.top -
        50;
    return OKToast(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cancel", style: Theme.of(context).textTheme.subtitle2),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Text(
                      "Welcome back",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: HooTextField(
                    Icons.face,
                    Strings.login_account_hint,
                    (txt) {
                      this.account = txt;
                      _onTextChange();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: HooTextField(
                    Icons.lock_open,
                    Strings.login_pwd_hint,
                    (txt) {
                      this.pwd = txt;
                      _onTextChange();
                    },
                    isPassWord: true,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 100),
                  child: HooButton(
                    isButtonEnable,
                    Strings.sign_in_login,
                    () async {
                      DBProvider provider = DBProvider.getInstance();
                      User user =
                          await provider.queryUserByNameAndPwd(account, pwd);
                      if (user != null) {
                        print(user.id);
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MainPage()));
                      } else {
                        showToast("用户名或者密码错误！！！！",textPadding: EdgeInsets.all(10));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
