// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sheet {
  final String name;
  final DateTime date;
  final String uid;
  final List<dynamic> share;

  Sheet({
    required this.uid,
    required this.name,
    required this.date,
    required this.share,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'date': date,
      'share': share,
    };
  }

  factory Sheet.fromMap(Map<String, dynamic> map) {
    return Sheet(
      uid: map['uid'] as String,
      name: map['name'] as String,
      date: map['date'].toDate(),
      share: map['share'] as List,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sheet.fromJson(String source) =>
      Sheet.fromMap(json.decode(source) as Map<String, dynamic>);
}
