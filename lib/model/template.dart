// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class CTemplate {
  final Alignment alignment;
  final TextAlign textAlign;
  final String name;
  Offset? position;
  CTemplate({
    this.position,
    required this.alignment,
    required this.textAlign,
    required this.name,
  });

  CTemplate copyWith({
    Offset? position,
    Alignment? alignment,
    TextAlign? textAlign,
    String? name,
  }) {
    return CTemplate(
      position: position ?? this.position,
      alignment: alignment ?? this.alignment,
      textAlign: textAlign ?? this.textAlign,
      name: name ?? this.name,
    );
  }

  factory CTemplate.fromMap(Map<String, dynamic> map) {
    return CTemplate(
      position: map['position'],
      alignment: map['alignment'],
      textAlign: map['textAlign'],
      name: map['name'],
    );
  }

  factory CTemplate.fromJson(String source) => CTemplate.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CTemplate(position: $position, alignment: $alignment, textAlign: $textAlign, name: $name)';

  @override
  bool operator ==(covariant CTemplate other) {
    if (identical(this, other)) return true;

    return other.position == position && other.alignment == alignment && other.textAlign == textAlign && other.name == name;
  }

  @override
  int get hashCode => position.hashCode ^ alignment.hashCode ^ textAlign.hashCode ^ name.hashCode;
}
