
class Home{
  int stevedors;
  int transactions;

 

 


  Home({
    required this.stevedors,
    required this.transactions,



   
  });


  factory Home.fromJson(Map<String, dynamic> json){
    return Home(
      stevedors: json['stevedors_in'],
      transactions: json['transactions'],
    );
  }
}