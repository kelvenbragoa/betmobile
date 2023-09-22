import 'package:estivadorapp/constants.dart';
import 'package:estivadorapp/models/api_response.dart';
import 'package:estivadorapp/models/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




Future<ApiResponse> getHomeData () async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;





  List<Home> home =[];

  try{
   
    
    final response = await http.get(
      Uri.parse(homeURL),

     
      headers: {'Accept':'application/json'}
    );


    
  
  

    

      
   
   

    
  var values = jsonDecode(response.body)['home'];

    

      
   
   

    
  
    if(values.length>0){
    
       for(int i=0;i<values.length;i++){

          
           if(values[i]!=null){

            
             Map<String,dynamic> map = values[i];
          
             home.add(Home.fromJson(map));
           
             
           
           }}
    }


    
    
   
   
    switch (response.statusCode) {
      case 200:
        apiResponse.data = home;
        apiResponse.data as List<dynamic>;

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