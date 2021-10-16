import 'package:data_collection/api/auth_service.dart';
import 'package:data_collection/util/appException.dart';
import 'package:flutter/cupertino.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
  Error,
  Initial,
  Loading,
  Completed,
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;

  Status get loggedInStatus => _loggedInStatus;

  var authService = AuthService();

  // User wants to remain logged in app
  bool _stayLoggedIn = true;

  bool get stayLogged => _stayLoggedIn;

  bool stayLoggedIn(value) {
    _stayLoggedIn = value;
    notifyListeners();
    return _stayLoggedIn;
  }

  // Text field auto validation
  bool _autoValidate = false;

  bool get autoValidate => _autoValidate;

  bool autoValidated() {
    _autoValidate = true;
    notifyListeners();
    return _autoValidate;
  }

  delayLogin() {
    _loggedInStatus = Status.NotLoggedIn;
    notifyListeners();
  }

  AppException _failure;

  AppException get failure => _failure;

  void _setFailure(AppException failure) {
    _failure = failure;
    notifyListeners();
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    var result;
    // Set login status to authenticating
    _loggedInStatus = Status.Authenticating;
    //_state = Status.Loading;
    // Notify Listeners
    notifyListeners();
    try {
      // Login Request with email and password
      var response = await authService.login(email, password);
      print('auth response: $response');
      // Get token from response
      // var token = response['data']['token'];

      // // Retrieve patient info using token
      // // var info = await getPatient(token);
      // // Patient id
      // // var patientId = info['data']['_id'];
      // // // Patient email
      // // var userEmail = info['data']['email'];
      // // // Patient first name
      // // var firstname = info['data']['firstname'];
      // // // Patient surname
      // // var surname = info['data']['lastname'];
      // // // Patient date of birth
      // // var dob = info['data']['dob'];

      // print('auth.dart:  $token');

      // Map<String, dynamic> userData = {
      //   'firstname': firstname, //user.firstname,
      //   'lastname': surname, //user.surname,
      //   'email': userEmail, //user.email,

      //   'token': token
      // };

      // // store user data in user object
      // User authUser = User.fromJson(userData);
      // if (_stayLoggedIn) {
      //   // save using shared prefs
      //   UserPreferences().saveUser(authUser);
      // }
      result = {'status': true, 'message': 'Successful'};
      // Change login status to logged in
      _loggedInStatus = Status.LoggedIn;
      //_state = Status.Completed;
      // Notify Listeners
      notifyListeners();

      return result;
    } on AppException catch (e) {
      _setFailure(e);
      print(e);
      _loggedInStatus = Status.Error;
      //_state = Status.Error;
      notifyListeners();
      result = {
        'status': false,
        'message': 'Registration failed',
        //'data': responseData
      };
    }

    return result;
  }

  // /// Get single patient data
  // Future<Map<String, dynamic>> getUser(token) async {
  //   try {
  //     // Request
  //     var info = await authService.getPatients(token);
  //     print('info $info');
  //     return info;
  //   } on AppException catch (e) {
  //     _setFailure(e);
  //   }
  // }
}
