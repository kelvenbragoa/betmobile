
import 'dart:convert';

import 'package:estivadorapp/models/transaction.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/api_response.dart';

Future<ApiResponse> getTransactions () async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<TransactionModel> _sellList =[];
  try{
   
    
    final response = await http.get(
      Uri.parse(transactionURL),
      headers: {'Accept':'application/json'}
    );


   
    var values = jsonDecode(response.body)['transactions'];
    print(values);



    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            _sellList.add(TransactionModel.fromJson(map));
             
           
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = _sellList;
        apiResponse.data as List<dynamic>;
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
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
//funcional
  //return data;\

  return apiResponse;
}