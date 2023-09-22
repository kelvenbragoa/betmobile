
class QRcodeInfo{
  int nomeEstivador;
  int transaction;
  int guia;

 

 


  QRcodeInfo({
    required this.nomeEstivador,
    required this.transaction,
    required this.guia,



   
  });


  factory QRcodeInfo.fromJson(Map<String, dynamic> json){
    return QRcodeInfo(
      nomeEstivador: json['estivadores']['nome'],
      transaction: json['transaction'],
      guia: json['guia'],

    );
  }
}