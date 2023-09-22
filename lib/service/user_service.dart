import 'dart:convert';
import 'package:estivadorapp/constants.dart';
import 'package:estivadorapp/models/api_response.dart';
import 'package:estivadorapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


// login
Future<ApiResponse> loginUser (String user, String password) async {

  print('iniciando chamada de login');
  print(loginURL);

  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
      Uri.parse(loginURL),
      headers: {'Accept':'application/json'},
      body: {
        'email':user,
        'password':password
      }
    );


var values = jsonDecode(response.body);
    
    print(values);

    




    switch (response.statusCode) {
      case 200:
      print('chegou');
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      
      case 422:
       final errors = jsonDecode(response.body)['errors'];
      //  apiResponse.error = errors[errors.keys.elementAt(0)[0]];
       apiResponse.error = errors.toString();
       break;

      case 403:
      apiResponse.error = jsonDecode(response.body)['message'];
      break;

      default:
      apiResponse.error = somethingwentwrong;
    }
  }catch (e){

    
    apiResponse.error = serverError;
  }

  return apiResponse;
}




Future<ApiResponse> getUserDetails (int ?userid, BuildContext context) async {
  ApiResponse apiResponse = ApiResponse();

  try{
    // String token = await getToken();
    
    final response = await http.get(
      Uri.parse('$userURL/$userid'),
      headers: {'Accept':'application/json',})
     ;
    
   

   
    switch (response.statusCode) {
      
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        
        break;
      
      case 401:
       
       apiResponse.error = unauthorized;
       break;


      default:
      apiResponse.error = somethingwentwrong;
    }
  }catch (e){

    apiResponse.error = serverError;

  }

  return apiResponse;
}





// get user id

Future<String?> getUserId() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? userid = pref.getString('userId');
  return userid;
}


// get user id

Future<bool> logout() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove('userId');
  pref.remove('token');
  return await pref.remove('token');
}