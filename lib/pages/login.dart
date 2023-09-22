import 'package:estivadorapp/constants.dart';
import 'package:estivadorapp/models/api_response.dart';
import 'package:estivadorapp/models/user.dart';
import 'package:estivadorapp/pages/components/header.dart';
import 'package:estivadorapp/pages/home.dart/Home.dart';
import 'package:estivadorapp/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   Future<void> _login() async {
  
    
    ApiResponse response = await loginUser(_usercontroller.text,_passwordcontroller.text);
    

        
    if(response.error == null){
      _saveAndRedirectToHome(response.data as User);
    }else{
       setState(() {
              loading = false;
            });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
        ));
    }
  }

   void _saveAndRedirectToHome(User user) async{
  
    setState(() {
      userProfile = user;
    });
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('token', user.token);
    await pref.setInt('userid', user.id);
    // ignore: use_build_context_synchronously

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));

  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _usercontroller = TextEditingController(text: '');
  final TextEditingController _passwordcontroller = TextEditingController(text: '');

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
        backgroundColor: const Color.fromARGB(255, 72, 72, 72),
        elevation: 0,
        title: Text('Estivador App')
      ),
      body: SingleChildScrollView(
        padding:  const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            const Header(title: 'Entrar',),
            

            const SizedBox(height: defaultPadding,),
           

            

           
           

            Form(
        key: _key,
        
            child: SingleChildScrollView(
              child: Column(
                 
                 mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                 
            
                         
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _usercontroller,
            
                      decoration: const InputDecoration(
                        labelText: 'Email'
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Campo Obrigatório.';
                        }
                       
                        // return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _passwordcontroller,
            
                      decoration: const InputDecoration(
                        labelText: 'Password'
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Campo Obrigatório.';
                        }
                       
                       
                        // return null;
                      },
                    ),
                  ),

                 
                     
            
                 loading ? Padding(padding: const EdgeInsets.all(8),
                    child: Center(child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Por favor aguarde')
                      ],
                    )),
                  ) : 
                  
            
                  Padding(padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Entrar'),
                    onPressed: (){
                      
                     if(_key.currentState!.validate()){
                       _key.currentState!.save();
                       setState(() {
                        loading = true;
                      });
                      _login();
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                     }
                    },
                  ),
                  )
                 
                ],
              ),
            ),
         
      ),
           
            
            
          ],
        ),

      ),
    );

  }
    
  }

