import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

import '../validators/auth_validators.dart';

import '../widgets/carousel.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = 'auth/';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  String userName;
  String email;
  String password;
  String passwordConfirm;

  bool isLogin = true;

  // password visiblity
  bool isPassword1Visible = false;
  bool isPassword2Visible = false;

  showModal({String title, String content, bool isError = true}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: Text(
          title,
          style: TextStyle(color: isError ? Colors.red : Colors.green),
        ),
        content: Text(
          content,
          style: TextStyle(color: Colors.grey[350]),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
            ),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void submitForm() async {
    if (isLogin) {
      Provider.of<AuthProvider>(context,listen: false)
          .login(
        userName: this.userName,
        password: this.password,
      )
          .then((value) {
        Navigator.of(context).pushReplacementNamed('/');
      }).catchError((error) {
        this.showModal(
          title: 'An Error Occured',
          content: 'Unable to Login at the moment',
        );
      });
    } else {
      Provider.of<AuthProvider>(context,listen: false)
          .signup(
        userName: this.userName,
        email: this.email,
        password: this.password,
      )
          .then((value) {
        setState(() {
          isLogin = true;
        });
      }).catchError((error) {
        this.showModal(
          title: 'An Error Occured',
          content: 'Unable to Sign Up at the moment',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: this._form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (this.isLogin && MediaQuery.of(context).viewInsets.bottom == 0)
                Carousel(),
              if (this.isLogin && MediaQuery.of(context).viewInsets.bottom == 0)
                SizedBox(
                  height: 40,
                ),
              TextFormField(
                key: ValueKey('userName'),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.grey[350]),
                  filled: true,
                  fillColor: Colors.grey[850],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) => userNameValidator(value),
                onChanged: (value) {
                  this.setState(() {
                    userName = value;
                  });
                },
                onSaved: (newValue) {
                  this.setState(() {
                    userName = newValue;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (!isLogin)
                TextFormField(
                  key: ValueKey('email'),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey[350]),
                    filled: true,
                    fillColor: Colors.grey[850],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) => emailValidator(value),
                  onChanged: (value) {
                    this.setState(() {
                      email = value;
                    });
                  },
                  onSaved: (newValue) {
                    this.setState(() {
                      email = newValue;
                    });
                  },
                ),
              if (!isLogin)
                SizedBox(
                  height: 20,
                ),
              TextFormField(
                key: ValueKey('password'),
                style: TextStyle(color: Colors.white),
                obscureText: !this.isPassword1Visible,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        this.isPassword1Visible = !this.isPassword1Visible;
                      });
                    },
                    color: Colors.grey[350],
                    icon: this.isPassword1Visible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey[350]),
                  filled: true,
                  fillColor: Colors.grey[850],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) => passwordValidator(value),
                onChanged: (value) {
                  this.setState(() {
                    password = value;
                  });
                },
                onSaved: (newValue) {
                  this.setState(() {
                    password = newValue;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (!isLogin)
                TextFormField(
                  key: ValueKey('passwordConfirm'),
                  style: TextStyle(color: Colors.white),
                  obscureText: !this.isPassword2Visible,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                    onPressed: () {
                        setState(() {
                          this.isPassword2Visible = !this.isPassword2Visible;
                        });
                      },
                      color: Colors.grey[350],
                      icon: this.isPassword2Visible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    hintText: 'Password Confirm',
                    hintStyle: TextStyle(color: Colors.grey[350]),
                    filled: true,
                    fillColor: Colors.grey[850],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) =>
                      passwordConfirmValidator(value, this.password),
                  onChanged: (value) {
                    this.setState(() {
                      passwordConfirm = value;
                    });
                  },
                  onSaved: (newValue) {
                    this.setState(() {
                      passwordConfirm = newValue;
                    });
                  },
                ),
              if (!isLogin)
                SizedBox(
                  height: 20,
                ),
              RaisedButton(
                child: Text(
                  this.isLogin ? 'Login' : 'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color.fromRGBO(5, 138, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onPressed: this.submitForm,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.isLogin
                        ? 'Create an Account ?'
                        : 'Already a member ? ',
                    style: TextStyle(color: Colors.grey[350]),
                  ),
                  SizedBox(
                    width: this.isLogin ? 90 : 70,
                    child: FlatButton(
                      child: Text(this.isLogin ? 'Sign Up' : 'Login'),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: Color.fromRGBO(5, 138, 255, 1),
                      onPressed: () {
                        setState(() {
                          this.isLogin = !this.isLogin;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
