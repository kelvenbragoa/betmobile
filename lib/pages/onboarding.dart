import 'package:estivadorapp/constants.dart';
import 'package:estivadorapp/pages/login.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({ Key? key }) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final controller = PageController();
  bool isLastPage = false;


  @override
  void dispose() {
   
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(()=> isLastPage = index==2);
          },
          children: [
            Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                     
                
                  const SizedBox(height: defaultPadding,),
                  const Text(
                    'Estivador APP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  const SizedBox(height: defaultPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text('Estivador APP',textAlign: TextAlign.center,),
                  )
                  
                ],
              ),
            ),
            Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                    
                  const SizedBox(height: defaultPadding,),
                  const Text(
                    'Esitvador APP',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: defaultPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text('Estivador APP',textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  const SizedBox(height: defaultPadding,),
                  const Text(
                    'Estivador APP',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: defaultPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text('Estivador APP',textAlign: TextAlign.center,),
                  )
                  
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage ? 
      TextButton(
        style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(5) 
            ),
        minimumSize: const Size.fromHeight(80)
        ),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
          
        }, 
        child: const Text('Iniciar')
        ) : 
        
        Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: (){
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                controller.jumpToPage(2);
              }, 
              child: const Text('Saltar')),
            
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                onDotClicked: (index) => controller.animateToPage(
                  index, 
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeInOut),
              ),
            ),

            TextButton(
              onPressed: (){
                controller.nextPage(
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeInOut);
              }, 
              child: const Text('Próximo'))
          ],
        ),
      ),
    );
  }
}