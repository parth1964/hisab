// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  final String title;
  final String note;

  Note({
    required this.title,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'note': note,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] as String,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);
}
