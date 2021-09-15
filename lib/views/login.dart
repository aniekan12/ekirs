import 'package:data_collection/api/auth_service.dart';
import 'package:data_collection/providers/auth.dart';
import 'package:data_collection/providers/user_provider.dart';
import 'package:data_collection/userdata/user.dart';
import 'package:data_collection/util/colors.dart';
import 'package:data_collection/util/error_handler.dart';
import 'package:data_collection/util/shared_pref_util.dart';
import 'package:data_collection/views/dashboard.dart';
import 'package:data_collection/views/propertydetails.dart';
import 'package:data_collection/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = _emailController.text.toString();
    });
    prefs.setString('email', _email);
  }

  final formKey = new GlobalKey<FormState>();
  final formKeys = new GlobalKey<FormState>();
  static const double figureHeight = 250;

  // Text form field controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Text field container height
  double _textFieldHeight = 48;

  // Thickness of Text fields
  double _textFieldBorderWidth = 1;

  // Text size
  double _textSize = 14;

  // Text field box shadow
  Color _textFieldShadow = Color.fromRGBO(0, 0, 0, 0.5);

  // TODO CHANGE TO PROVIDER
  // Hide password
  bool _obscureText = true;
  double heightValue = 120;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: back,
      body: Container(
        child: Opacity(
          opacity: auth.loggedInStatus == Status.Authenticating ||
                  auth.loggedInStatus == Status.LoggedIn
              ? 0.4
              : 1,
          child: AbsorbPointer(
            absorbing: auth.loggedInStatus == Status.Authenticating ||
                auth.loggedInStatus == Status.LoggedIn,
            child: Stack(
              children: [
                Form(
                  key: formKey,
                  autovalidateMode: auth.autoValidate
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: _buildLoginForm(context),
                ),
                Opacity(
                  opacity: 1,
                  child: AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: auth.loggedInStatus == Status.Authenticating
                          ? Center(child: loadingSpinner(48.0, 2.0))
                          : auth.loggedInStatus == Status.LoggedIn
                              ? Center(
                                  child: onComplete(
                                      "Login Success",
                                      Icons.check_circle,
                                      buttonColorOne,
                                      heightValue,
                                      context))
                              : auth.loggedInStatus == Status.Error
                                  ? Center(
                                      child: onComplete(
                                          "Login failed",
                                          Icons.cancel,
                                          buttonColorOne,
                                          heightValue,
                                          context))
                                  : null),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLoginForm(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    // Ensure correct data was entered
    checkFields() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        return true;
      }
      // Set auto validate to true
      auth.autoValidated();
      return false;
    }

    // Login
    var login = () async {
      FocusScope.of(context).unfocus();
      // Login Request
      final response =
          await auth.signIn(_emailController.text, _passwordController.text);
      // Check if there's response
      if (response != null) {
        // true
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Future.delayed(Duration(milliseconds: 6000)).then(
            (value) => Navigator.pushReplacementNamed(context, '/dashboard'));
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            heightValue = 200.0;
            //bottom = 100;
          });
        });
        /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => PatientDashboard(user: response['user'],)),
                (Route<dynamic> route) => false));*/
        //Provider.of<UserProvider>(context).setUser(response['user']);
      } else {
        // false
        print('response');
        // Error Alert dialog
        ErrorHandler().errorDialog(context, auth.failure.toString());
        //Snackbar to display error message
        SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(auth.failure.toString()),
        );
        Future.delayed(Duration(milliseconds: 4000))
            .then((value) => auth.delayLogin());
      }
    };
    // Stay logged in
    var stayLogged = (value) {
      final response = auth.stayLoggedIn(value);
      return response;
    };

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 80, 24.0, 24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 40.0),
          Text(
            'Welcome back',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Email',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Container(
              //height: _textFieldHeight,
              decoration: boxDecoration(),
              child: Theme(
                data: Theme.of(context).copyWith(primaryColor: buttonColorTwo),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: buildDecoration(
                      buttonColorTwo,
                      _textFieldBorderWidth,
                      _textSize,
                      Icons.email,
                      'myemail@gmail.com',
                      false),
                  validator: (value) => validateEmail(value),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  maxLength: 40,
                ),
              )),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Password',
                style: TextStyle(
                    fontSize: _textSize, fontWeight: FontWeight.w500)),
          ),
          Container(
            //height: _textFieldHeight,
            decoration: boxDecoration(),
            child: Theme(
              data: Theme.of(context).copyWith(primaryColor: buttonColorTwo),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: _obscureText,
                enableSuggestions: false,
                autocorrect: false,
                decoration: buildDecoration(
                  buttonColorTwo,
                  _textFieldBorderWidth,
                  _textSize,
                  Icons.lock,
                  'Password',
                  true,
                  IconButton(
                    icon: Icon(
                        _obscureText == true
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 24.0,
                        color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) => value.isEmpty
                    ? 'Password is required'
                    : value.length < 3
                        ? 'Password must be at least 6 characters'
                        : null,
                textAlign: TextAlign.start,
                maxLines: 1,
                maxLength: 20,
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(0.0),
            //   child: Checkbox(
            //       checkColor: Colors.white,
            //       activeColor: buttonColorTwo,
            //       value: auth.stayLogged,
            //       onChanged: (bool newValue) {
            //         stayLogged(newValue);
            //       }),
            // ),
          ]),
          SizedBox(height: 40.0),
          GestureDetector(
              onTap: () {
                print(_emailController.text);
                print(_passwordController.text);
                if (checkFields()) {
                  login();
                  _incrementCounter();
                }
              },
              child: signButton(
                  _textFieldHeight, _textFieldShadow, _textSize, 'SIGN IN')),
          SizedBox(height: 30.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(width: 5.0),
          ]),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(width: 5.0),
          ])
        ]),
      ),
    );
  }
}
