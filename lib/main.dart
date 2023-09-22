import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:estivadorapp/constants.dart';
import 'package:estivadorapp/models/api_response.dart';
import 'package:estivadorapp/models/user.dart';
import 'package:estivadorapp/pages/login.dart';
import 'package:estivadorapp/pages/onboarding.dart';
import 'package:estivadorapp/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkStatus();
  }

   Future<void> _checkStatus() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiResponse response = ApiResponse();

    
    
    

    if(pref.getInt('userId') == null){
      return;
    }else{

       try{

          response = await getUserDetails(pref.getInt('userId'),context);

          
          
          if(response.data == null){
            
            setState(() {
              status = false;
            });
          }else{
           
            userProfile = response.data as User;
            setState(() {
              status = true;
            });

            
          }
          

          

          

       } catch (e){
         response.error = serverError;
       }

       
    }




  }

  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Estivador APP',
      // theme: ThemeData.dark(),
       theme: ThemeData.light().copyWith(
         scaffoldBackgroundColor: bgColor,
         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
             .apply(bodyColor: Color.fromARGB(255, 0, 0, 0)),
         canvasColor: secondaryColor,
      
       ),
      home: AnimatedSplashScreen(
       
        duration: 1500,
        splash: const Center(child: Text('Estivador App'),),
        nextScreen: status ? const LoginPage() :  const Onboarding() ),
    );
  }
}





