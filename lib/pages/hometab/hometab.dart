import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/api_response.dart';
import '../../models/home.dart';
import '../../service/home.dart';
import '../../service/user_service.dart';
import '../login.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}


class _HomeTabState extends State<HomeTab> {

  List<dynamic> homeDashboard = [];
    bool _loading = true;
    late Home home;

    Future<void> retrieveData()async{

    
    
    ApiResponse response = await getHomeData();

    print(response.data);

    if(response.error == null){
      setState(() {
        homeDashboard = response.data as List<dynamic>;
        home = homeDashboard[0];
         _loading = _loading ? !_loading : _loading;
      });

      

  

    }else if(response.error == unauthorized){
      logout().then((value)  {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const LoginPage()), (route) => false);
      });
    }else{
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 

    

   

  }
  @override
  void initState() {
    // TODO: implement initState
     retrieveData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text('Painel',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('Guias Autorizadas'),
                       Icon(Icons.list),
                    ],
                  ),
                 
                  _loading ? Padding(padding: const EdgeInsets.all(8),
                      child: Center(child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          
                        ],
                      )),
                    ) :
                      Text(
                        '${home.transactions}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                ],
              ),
            
               Column(
                children: [
                  Row(
                    children: [
                      Text('Parque'),
                       Icon(Icons.supervised_user_circle),
                    ],
                  ),
                 
                  _loading ? Padding(padding: const EdgeInsets.all(8),
                      child: Center(child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          
                        ],
                      )),
                    ) :
                      Text(
                        '${home.stevedors}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                ],
              )
            ],
          ),

          Divider(),

          ListTile(
            title: Text('Usuario'),
            subtitle: Text(userProfile.name),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text(userProfile.email),
          ),
           ListTile(
            title: Text('ID'),
            subtitle: Text('${userProfile.id}'),
          ),
          
        ],
      ),
    );
  }
}
