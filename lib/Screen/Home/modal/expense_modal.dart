import 'dart:typed_data';

class ExpenseModel
{

  int? id,amount;
  String? category,note,status,date,time;
  Uint8List? img;
  ExpenseModel({this.id,this.note, this.amount, this.category, this.status,this.date,this.time,this.img});

}