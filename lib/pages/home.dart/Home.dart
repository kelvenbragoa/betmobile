import 'package:estivadorapp/pages/hometab/hometab.dart';
import 'package:estivadorapp/pages/list/transaction.dart';
import 'package:estivadorapp/pages/scanner/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';





class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return const MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
    const HomeTab(),
    const Scanner(),
    const Transaction()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 72, 72, 72),
        elevation: 0,
        title: Text('Estivador APP')
        // actions: <Widget>[
        //   IconButton(
        //       icon: const Icon(
        //         Icons.camera_enhance,
        //         color: Color(0xFF3a3737),
        //       ),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => Scanner()),
        //         );
               
        //         })
        // ], systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        items: const <BottomNavigationBarItem>[
          
          
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scanner',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),
          ),

           
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transaction',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),
          ),
         
         
          
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        
        
        elevation: 10.0,
        // unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),

        onTap: _onItemTapped,
      ),
    );
  }
}

