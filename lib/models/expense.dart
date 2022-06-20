// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Expense {
 
  final String name;
  final double price;
  final int quantity;
  final double total;
  final DateTime date;
  final String? detail;

  Expense({

    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
    required this.date,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'date': date,
      'quantity': quantity,
      'total': total,
      'detail': detail,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      name: map['name'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      total: map['total'] as double,
      date: map['date'].toDate(),
      detail: map['detail'] != null ? map['detail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);
}
