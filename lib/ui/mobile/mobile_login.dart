import 'package:flutter/material.dart';
import 'package:stellar_anchor_library/api/auth.dart';
import 'package:stellar_anchor_library/util/functions.dart';
import 'package:stellar_anchor_library/util/snack.dart';
import 'package:stellar_anchor_library/util/util.dart';

class LoginMobile extends StatefulWidget {
  @override
  _LoginMobileState createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> implements SnackBarListener {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isBusy = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.brown[100],
        body: isBusy
            ? Center(
                child: Container(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 24,
                    backgroundColor: Colors.teal[800],
                  ),
                ),
              )
            : Stack(
                children: <Widget>[
                  Center(child: LoginForm()),
                ],
              ),
      ),
      onWillPop: () => doNothing(),
    );
  }

  Future<bool> doNothing() async {
    return false;
  }

  @override
  onActionPressed(int action) {
    // TODO: implement onActionPressed
    return null;
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  TextEditingController emailCntr = TextEditingController();
  TextEditingController pswdCntr = TextEditingController();
  AnimationController titleController;
  Animation titleAnimation, btnAnimation;

  bool isBusy = false;
  Animation<double> boxAnimation;
  Animation<double> classificationAnimation;
  Animation<Offset> pulseAnimation;
  Animation<Offset> meanAnimation;
  @override
  void initState() {
    super.initState();
    emailCntr.text = 'a_1587785499650@anchor.com';
    pswdCntr.text = 'pTiger3#Word!isWannamaker#23';
    _setUpAnimation();
  }

  _setUpAnimation() {
    titleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    titleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: titleController,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut)));
    btnAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: titleController,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut)));

    titleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        p(".......... 💦 💦 💦 Title Animation completed");
      }
    });

    titleController.forward();
  }

  var _key = GlobalKey<ScaffoldState>();

  void _onEmailChanged(String value) {
    print(value);
  }

  void _signIn() async {
    if (emailCntr.text.isEmpty || pswdCntr.text.isEmpty) {
      AppSnackBar.showErrorSnackBar(
          scaffoldKey: _key,
          message: "Credentials missing or invalid",
          actionLabel: 'Error');
      return;
    }
    setState(() {
      isBusy = true;
    });
    try {
      var user = await Auth.signInAnchor(
          email: emailCntr.text, password: pswdCntr.text);
      print('✳️ ️signed in ok, ✳️ popping ..... anchorUser: ${user.toJson()}');
      Navigator.pop(context, true);
    } catch (e) {
      print(e);
      setState(() {
        isBusy = false;
      });
      AppSnackBar.showErrorSnackBar(
          scaffoldKey: _key,
          message: 'We have a problem $e',
          actionLabel: 'Err');
    }
  }

  void _onPasswordChanged(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 1,
                color: baseColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      ScaleTransition(
                        scale: titleAnimation,
                        alignment: Alignment(0.0, 0.0),
                        child: GestureDetector(
                          onTap: () {
                            titleController.reset();
                            titleController.forward();
                          },
                          child: Row(
                            children: <Widget>[
                              Hero(
                                tag: 'logo',
                                child: Image.asset(
                                  'assets/logo/logo.png',
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Anchor Sign in',
                                style: Styles.blackBoldMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(dummy),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        onChanged: _onEmailChanged,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailCntr,
                        style: Styles.blueBoldSmall,
                        decoration: InputDecoration(
                            hintText: 'Enter  email address',
                            labelText: 'Email'),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextField(
                        onChanged: _onPasswordChanged,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: pswdCntr,
                        decoration: InputDecoration(
                            hintText: 'Enter password', labelText: 'Password'),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      ScaleTransition(
                        scale: btnAnimation,
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                              boxShadow: customShadow,
                              color: Colors.brown[100]),
                          child: isBusy
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : FlatButton(
                                  onPressed: () {
                                    p('💙 tapped to go logging in ...');
                                    _signIn();
                                  },
                                  child: Text(
                                    "Submit Credentials",
                                    style: Styles.blackBoldSmall,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
