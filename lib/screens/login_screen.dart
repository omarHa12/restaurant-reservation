// ignore_for_file: prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:resrev/constants.dart';
import 'package:resrev/screens/home_screen.dart';
import 'package:resrev/screens/register_screen.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class LoginPage extends StatefulWidget {

static const id = "LoginPage";

  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late bool _isShowPwd;
  bool _hasError = false;
  late String _errorMessage;

  @override
  void initState() {
    _isShowPwd = false;
    _usernameController.text = '';
    _passwordController.text = '';
    initData().then((bool success) {
      setState(() {
        _hasError = !success;
      });
    }).catchError((dynamic _) {
      setState(() {
        _hasError = true;
      });
    });
    super.initState();
  }

  Future<bool> initData() async {
    await Parse().initialize(
      keyApplicationId,
      keyServerUrl,
      clientKey: keyClientKey,
      debug: keyDebug,
    );

    return (await Parse().healthCheck()).success;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/back4app.png"),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Username'),
                  controller: _usernameController,
                  validator: (value) =>
                      (value!.isEmpty) ? "Please Enter Username" : null,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Password'),
                  controller: _passwordController,
                  validator: (value) =>
                      (value!.isEmpty) ? "Please Enter Password" : null,
                  obscureText: (_isShowPwd) ? false : true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isShowPwd = !_isShowPwd;
                        });
                      },
                      child: _isShowPwd? Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            )
                          : Icon(Icons.visibility_off,
                              color:  Colors.grey),
                    ),
                  ),
                ),
                _hasError
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: kErrorColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _errorMessage,
                              style: TextStyle(
                                  color: kErrorColor),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.orange,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        _hasError = false;
                      }); //reset previous error message

                      if (_formKey.currentState!.validate()) {
                        ParseUser user = ParseUser(_usernameController.text.trim(),
                            _passwordController.text.trim(), '');
                        ParseResponse response = await user.login();

                        _usernameController.clear();
                        _passwordController.clear();

                        if (response.success) {
                          Navigator.pushNamed(
                              context,
                              HomePage.id);
                        } else {
                          setState(() {
                            _hasError = true;
                            _errorMessage = response.error!.message;
                          });
                        }
                      }
                    },
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text(
                    '_____OR_____',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RegisterPage.id
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "You don't have an account yet? ",
                      style: TextStyle(color: Colors.black54),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: kSplashFirstColor,
                          ),
                        ),
                      ],
                    ),
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
