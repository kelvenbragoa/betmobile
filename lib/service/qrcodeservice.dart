import 'package:estivadorapp/constants.dart';
import 'package:estivadorapp/models/api_response.dart';
import 'package:estivadorapp/models/home.dart';
import 'package:estivadorapp/models/qrcodeinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




Future<ApiResponse> getQRcodeInfo (int? id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;





  List<QRcodeInfo> qrcodeinfo =[];

  try{
   
    
    final response = await http.get(
      Uri.parse('$qrcodeinfo/$id'),

     
      headers: {'Accept':'application/json'}
    );

  
    var values = jsonDecode(response.body)['data'];

    

      
   
   

    
  
    if(values.length>0){
    
       for(int i=0;i<values.length;i++){

          
           if(values[i]!=null){

            
             Map<String,dynamic> map = values[i];
          
             qrcodeinfo.add(QRcodeInfo.fromJson(map));
           
             
           
           }}
    }

    
    
   
   
    switch (response.statusCode) {
      case 200:
        apiResponse.data = qrcodeinfo;
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