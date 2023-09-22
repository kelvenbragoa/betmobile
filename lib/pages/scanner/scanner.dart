import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../constants.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String _scanBarcode = 'Desconhecido';
  int status = 0;
  int responseStatus = 0;
  int errorcode = 0;
  String barcode = '';
  int actualstatus = 0;
  bool loading = false;

  String name = '';
  String contact = '';
  String document = '';
  String company = '';

  @override
  void initState() {
    super.initState();
  }

     Future<void> getStatus($id) async{

    int id2 = int.parse($id);

    setState(() {
      loading = true;
    });

    try{
    final response = await http.get(
          Uri.parse('${getDetailURL}/$id2'),
          headers: {'Accept':'application/json'}
        );

        var values = jsonDecode(response.body);
        

        setState(() {
          name = values['name'];
          contact = values['contact'];
          document = values['document'];
          company = values['company'];
          
          responseStatus = 1;
        });

       print(values);

    }catch(e){
      setState(() {
        loading = false;
      });
    }
  
    
  }

  Future<void> scanQR() async {
    int actual_status = 0;
    int actual_error = 0;
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // barcodeScanRes
    // if(finalvalue.idEvento == userProfile.event_id){
    //   actual_status = 1;
    //   actual_error = 0;
    // }else{
    //   actual_error = 1;
    // }

    setState(() {
      status = 1;
      errorcode = actual_error;
      _scanBarcode = barcodeScanRes;

      barcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ElevatedButton(
                  //     onPressed: () => scanBarcodeNormal(),
                  //     child: Text('Start barcode scan')),
                  Container(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      width: 250.00,
                      height: 250.00,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/cdm.png'),
                          fit: BoxFit.scaleDown,
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () => scanQR(),
                      child: const Text('Iniciar Scan QRCode')),
                  // ElevatedButton(
                  //     onPressed: () => startBarcodeScanStream(),
                  //     child: Text('Start barcode scan stream')),

                  status == 0
                      ? Container(
                          child: Text('Faça o scan',
                              style: TextStyle(fontSize: 18)),
                        )
                      : Column(
                          children: [
                            Container(
                              child: Text('Cracha # $barcode',
                                  style: TextStyle(fontSize: 18)),
                            ),
                            barcode != '-1'
                                ? ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(255, 27, 230, 37)),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) =>  SellsDetails(id:int.parse(barcode) )),
                                      // );
                                    },
                                    child: const Text('Clique aqui'))
                                : Container()
                          ],
                        ),
                        responseStatus == 1 ?
                  Column(
                    children: [
                      Center(
                        child: Text('Detalhes',
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
                      Center(
                          child: CircleAvatar(
                              maxRadius: 50,
                              backgroundImage:
                                  ExactAssetImage('assets/images/user.png'))),
                      ListTile(
                        title: Text('ID Guia:'),
                        subtitle: Text('#01'),
                      ),
                      ListTile(
                        title: Text('Nome:'),
                        subtitle: Text('Kelven Tercio'),
                      ),
                      ListTile(
                        title: Text('Estado atual:'),
                        subtitle: Text('Fora do Recinto'),
                      ),
                      ListTile(
                        title: Text('Documento:'),
                        subtitle: Text('0000000'),
                      ),
                      ListTile(
                        title: Text('Empresa:'),
                        subtitle: Text('NAVAL'),
                      ),
                      ListTile(
                        title: Text('Data Inicio:'),
                        subtitle: Text('01/01/2000'),
                      ),
                      ListTile(
                        title: Text('Data Fim:'),
                        subtitle: Text('01/01/2001'),
                      ),
                      ListTile(
                        title: Text('Status:'),
                        subtitle: Text('Expirada'),
                      ),
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                            color: Colors.green,
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Confirmar Transacao CheckIn'),
                                  content:
                                      actualstatus == 1 ? Text('Deseja realmente fazer o CheckIn e Reportar',style: TextStyle(color: Colors.red),) : Text('Deseja realmente fazer o CheckIn',style: TextStyle(color: Colors.green)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Sim'),
                                      child: const Text('Sim'),
                                    ),
                                  ],
                                ),
                              );
                              // showAboutDialog(
                              //     context: context,

                              //     children: [
                              //       actualstatus == 1 ?
                              //       Text('Deseja realmente fazer o CheckIn') :
                              //       Text('Deseja realmente fazer o Checkin e Reportar')
                              //       ]);
                            },
                            child: const Text(
                              'CheckIn',
                            )),
                        MaterialButton(
                            color: Colors.red,
                            onPressed: () => (
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Confirmar Transacao CheckOut'),
                                  content:
                                      actualstatus == 1 ? Text('Deseja realmente fazer o CheckOut e Reportar',style: TextStyle(color: Colors.red),) : Text('Deseja realmente fazer o CheckOut',style: TextStyle(color: Colors.green)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Sim'),
                                      child: const Text('Sim'),
                                    ),
                                  ],
                                ),
                              )
                            ),
                            child: const Text('CheckOut')),
                      ],
                    ),
                  )
                    ],
                  ):Container(),

                  
                ])),
      );
    }));
  }
}
