import 'package:estivadorapp/constants.dart';
import 'package:flutter/material.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 69, 69),
        title: Column(
      children: [
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
    Text('Estivador APP DETALHES',style: Theme.of(context).textTheme.subtitle1,
    ),
    ],
    ),
    const SizedBox(height: defaultPadding,),
      ],
    ),
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Center(
              child: Text('Detalhes',style: Theme.of(context).textTheme.subtitle1),
            ),
            ListTile(
              title: Text('ID Guia:'),
              subtitle: Text('#01'),
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
            )
          ],
        ),
      ),
    );
  }
}