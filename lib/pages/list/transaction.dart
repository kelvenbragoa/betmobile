import 'package:estivadorapp/models/transaction.dart';
import 'package:estivadorapp/service/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/api_response.dart';
import '../../service/user_service.dart';
import '../login.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
    bool _loading = true;

    bool _buttonLoading = false;
    
    List<dynamic> _transactionList = [];
    List<dynamic> _transactionListSearch = [];
    TextEditingController controller = TextEditingController(text: '');
    
      Future<void> retrieveTransaction() async{

    // userId = await getUserId();
    //var _transactionList = await getCategories();
    ApiResponse response = await getTransactions();
    
    
    /*
    setState(() {
        _transactionListT = _transactionList;
        _loading = _loading ? !_loading : _loading;
      });*/
   
    if(response.error == null){
      setState(() {
        _transactionList = response.data as List<dynamic>;
        _transactionListSearch = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if(response.error == unauthorized){
      logout().then((value)  {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      });
    }
    else{
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 
  }

void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];

    
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _transactionListSearch;
    } else {
      

     
      results = _transactionListSearch
          .where((transaction){

            return transaction.company.toString().contains(enteredKeyword.toLowerCase());
            
           
          })
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _transactionList = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    retrieveTransaction();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    
    return _loading ? const Padding(
      
      padding: EdgeInsets.all(8),
    
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                          
                        ],
                      )),
                    ) : Column(
                      children: [
                         Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: const Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Estivador App",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3a3a3b),
                              fontWeight: FontWeight.w300),
                        ),
                        
                      ],
                    ),
                    ),

                    Container(
                          margin: const EdgeInsets.all(4),
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Empresa',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Color.fromARGB(255, 76, 175, 163))
                              )
                            ),
                            onChanged: _runFilter,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.bottomLeft,
                          child: Text('Resultados: ${_transactionList.length}')
                        ),

                    Expanded(
                    child: ListView.builder(
                      itemCount: _transactionList.length,
                      itemBuilder: (BuildContext context, int index){
                        var status='';
                          var statusSell='';
                          
                           TransactionModel transaction = _transactionList[index];
                          
                          if(transaction.status == 0){status = 'Inválido';}
                          if(transaction.status== 1){status = 'Válido';}
                          return InkWell(
                            onLongPress: (){
                            },
                            
      
                            child: Card(
                              child: ListTile(                //return new ListTile(
                                 
                                 
                                  title: Text(transaction.company),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Inicio: ${transaction.startDate}'),
                                      Text('Fim: ${transaction.endDate}'),
                                      Text('Operação: ${transaction.operation}')
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_right),
                                  
                            
                              ),
                            ),
      
                          );

                          
                      }
                      )
                      )
                      ],
                    );
  }
}