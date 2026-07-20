import 'package:flutter/material.dart';

class Medication {
  final String id;
  final String title;
  final DateTime date;
  final String frequencyText; // 예: "1일 2정"
  final Color colorTag;

  Medication({
    required this.id,
    required this.title,
    required this.date,
    required this.frequencyText,
    required this.colorTag,
  });

  Medication copyWith({
    String? title,
    DateTime? date,
    String? frequencyText,
    Color? colorTag,
  }) {
    return Medication(
      id: id,
      title: title ?? this.title,
      date: date ?? this.date,
      frequencyText: frequencyText ?? this.frequencyText,
      colorTag: colorTag ?? this.colorTag,
    );
  }
}
