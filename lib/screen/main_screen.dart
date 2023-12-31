import 'package:flutter/material.dart';
import 'package:yummy_chat/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yummy_chat/screen/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication =
      FirebaseAuth.instance; // auth인스턴스 생성(외부 접근 방지를 위해 언더스코어를 붙여 프라이빗으로 생성)

  bool isSignupScreen = true; // 기본적으로 회원가입이 선택되게 보임
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner, // 전송버튼 눌렀을때 스피너 돌아감.
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('image/red.jpg'),
                              fit: BoxFit.fill)),
                      child: Container(
                        padding: EdgeInsets.only(top: 90, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Welcome',
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontSize: 25,
                                        color: Colors.white),
                                    children: [
                                  TextSpan(
                                      text: isSignupScreen
                                          ? ' to Yummy Chat!'
                                          : ' back',
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ])),
                            Text(
                              isSignupScreen
                                  ? 'Signup to continue'
                                  : 'Signin to continue',
                              style: TextStyle(
                                  letterSpacing: 1.0, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )),
                // 빨간 배경
                AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: 180,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      padding: EdgeInsets.all(20.0),
                      height: isSignupScreen ? 280.0 : 250.0,
                      width: MediaQuery.of(context).size.width - 40,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 5),
                          ]),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignupScreen = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: !isSignupScreen
                                                ? Palette.activeColor
                                                : Palette.textColor1),
                                      ),
                                      if (!isSignupScreen)
                                        Container(
                                          margin: EdgeInsets.only(top: 3),
                                          height: 2,
                                          width: 55,
                                          color: Colors.orange,
                                        )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignupScreen = true;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Signup',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSignupScreen
                                                ? Palette.activeColor
                                                : Palette.textColor1),
                                      ),
                                      if (isSignupScreen)
                                        Container(
                                          margin: EdgeInsets.only(top: 3),
                                          height: 2,
                                          width: 55,
                                          color: Colors.orange,
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            if (isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        key: ValueKey(1),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 4) {
                                            return 'Please enter at least 4 characters.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                        onSaved: (value) {
                                          userName = value!;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            hintText: 'User name',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor1),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        key: ValueKey(2),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.contains('@')) {
                                            return 'Please enter a valid email address.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        onSaved: (value) {
                                          userEmail = value!;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email_rounded,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            hintText: 'email',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor1),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        key: ValueKey(3),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return 'Please must be at least 7 characters long.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          userPassword = value;
                                        },
                                        onSaved: (value) {
                                          userPassword = value!;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            hintText: 'password',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor1),
                                            contentPadding: EdgeInsets.all(10)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            if (!isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        key: ValueKey(4),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.contains('@')) {
                                            return '이메일이 올바르지 않습니다.';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userEmail = value!;
                                        },
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email_rounded,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            hintText: 'email',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor1),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        key: ValueKey(5),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return '파이어베이스는 비번 6자 이상 넣어야함.';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userPassword = value!;
                                        },
                                        onChanged: (value) {
                                          userPassword = value;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            hintText: 'password',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor1),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    )),
                // 텍스트 폼 필드
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: isSignupScreen ? 430 : 390,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            showSpinner = true; // 스피너 돌아감.
                          });
                          if (isSignupScreen) {
                            _tryValidation();

                            try {
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                      email: userEmail, password: userPassword);

                              await FirebaseFirestore.instance
                                  .collection('user')  // 컬랙션이 자동 새로 생성됨.
                                  .doc(newUser.user!.uid)
                                  .set({
                                'userName': userName,
                                'email' : userEmail,
                              });

                              if (newUser.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ChatScreen();
                                  }),
                                );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Please check your email or password'),
                                backgroundColor: Colors.blue,
                              ));
                            }
                          }
                          if (!isSignupScreen) {
                            _tryValidation();

                            try {
                              final newUser = await _authentication
                                  .signInWithEmailAndPassword(
                                      email: userEmail, password: userPassword);
                              if (newUser.user != null) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) {
                                //     return ChatScreen();
                                //   }),
                                //);
                                setState(() {
                                  showSpinner = false; // 스피너 멈춤.
                                });
                              }
                            } catch (e) {
                              setState(() {
                                showSpinner = false; // 스피너 멈춤.
                              });
                              print(e);
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.red],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ]),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 화살표 전송 버튼
                AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: isSignupScreen
                        ? MediaQuery.of(context).size.height - 125
                        : MediaQuery.of(context).size.height - 165,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        Text(isSignupScreen
                            ? 'or Signup with'
                            : 'or Signin with'),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: Size(155, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Palette.googleColor),
                          icon: Icon(Icons.add),
                          label: Text('Google'),
                        )
                      ],
                    ))
                // 구글 로그인 버튼
              ],
            ),
          ),
        ));
  }
}
