import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_shop/Models/http_exception.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Auth with ChangeNotifier {
  String
      _tokens; //this token getting from firebase will stay for 1 hr then invalid
  DateTime _expiredate;
  String _userId;
  Timer _authTimer;
  String _emaill;
  bool get isAuth {
    return tokens != null;
  }

  String get tokens {
    if (_expiredate != null &&
        _expiredate.isAfter(DateTime.now()) &&
        _tokens != null) {
      return _tokens;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  String get emaill {
    return _emaill;
  }

  Future<void> _authincate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyC7Yd0RuzlQvL9blPLSl0JicvEXPPstV3M';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      // print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
        //throw HttpException;
      }
      _tokens = responseData['idToken'];
      _userId = responseData['localId'];
      _emaill = responseData['email'];

      _expiredate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();

      final userData = json.encode({
        //if u want to save a map as a string user json.encode
        'token': _tokens,
        'userId': _userId,
        'expiryDate': _expiredate.toIso8601String()
      });

      final sp = await SharedPreferences.getInstance();
      sp.setString('userData', userData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return await _authincate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return await _authincate(email, password, 'signInWithPassword');
  }

  Future<bool> tryautologin() async {
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(sp.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _tokens = extractedUserData['token'];
    _userId = extractedUserData['userId'];

    _expiredate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _tokens = _tokens != null ? null : null;
    _userId = null;
    _expiredate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();

    final sp = await SharedPreferences.getInstance();
    //sp.remove('userData');
    sp.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiredate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
    notifyListeners();
  }
}
