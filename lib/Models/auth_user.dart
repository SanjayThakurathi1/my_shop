import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_shop/Models/http_exception.dart';

class Auth with ChangeNotifier {
  String
      _tokens; //this token getting from firebase will stay for 1 hr then invalid
  DateTime _expiredate;
  String _userId;
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
      _userId = responseData['localData'];
      _expiredate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
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
}
