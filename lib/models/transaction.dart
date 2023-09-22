class TransactionModel {
  int id;
  String company;
  String startDate;
  String endDate;
  String operation;
  int status;

  
 

 


  TransactionModel({
    required this.id,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.operation,
    required this.status,
    
   
  });


  factory TransactionModel.fromJson(Map<String, dynamic> json){
    return TransactionModel(
      id: json['id'],
      company: json['company']['name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      operation: json['operation']['name'],
      status: json['status'],

      
    );
  }
}