// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:resrev/constants.dart';
import 'package:resrev/init_parse.dart';
import 'package:resrev/screens/home_screen.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class RegisterPage extends StatefulWidget {

static const id = "RegisterPage";

  RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late bool _isShowPwd;
  bool _hasError = false;
  late String _errorMessage;

  @override
  void initState() {
    _isShowPwd = false;
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
    _emailController.dispose();
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
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Username'),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Email address'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return 'Enter your email address';
                    } else if (!emailValid) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Password'),
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
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
                      child: _isShowPwd
                          ? Icon(
                              Icons.visibility,
                              color: Theme.of(context).primaryColor,
                            )
                          : Icon(Icons.visibility_off,
                              color: Theme.of(context).primaryColor),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                _hasError
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Theme.of(context).errorColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _errorMessage,
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
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
                  child: FlatButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ParseUser user = ParseUser(_usernameController.text,
                            _passwordController.text, _emailController.text);
                        ParseResponse response = await user.signUp();
                        
                        _usernameController.clear();
                        _passwordController.clear();
                        _emailController.clear();

                        if (response.success) {
                          Navigator.pushNamed(context, HomePage.id);
                        }else{
                          setState(() {
                            _hasError = true;
                            _errorMessage = response.error!.message;
                          });                          
                        }
                        //Got backt to Login page
                        // Navigator.of(context).pop();
                      }
                    },
                    child: Center(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
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
                  onTap: () => Navigator.of(context).pop(),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black54),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
