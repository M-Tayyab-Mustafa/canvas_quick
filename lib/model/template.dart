// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class CTemplate {
  final Alignment alignment;
  final TextAlign textAlign;
  final String name;
  CTemplate({
    required this.alignment,
    required this.textAlign,
    required this.name,
  });

  CTemplate copyWith({
    Alignment? alignment,
    TextAlign? textAlign,
    String? name,
  }) {
    return CTemplate(
      alignment: alignment ?? this.alignment,
      textAlign: textAlign ?? this.textAlign,
      name: name ?? this.name,
    );
  }

  factory CTemplate.fromMap(Map<String, dynamic> map) {
    return CTemplate(
      alignment: map['alignment'],
      textAlign: map['textAlign'],
      name: map['name'],
    );
  }

  factory CTemplate.fromJson(String source) => CTemplate.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CTemplate(alignment: $alignment, textAlign: $textAlign, name: $name)';

  @override
  bool operator ==(covariant CTemplate other) {
    if (identical(this, other)) return true;

    return other.alignment == alignment && other.textAlign == textAlign && other.name == name;
  }

  @override
  int get hashCode => alignment.hashCode ^ textAlign.hashCode ^ name.hashCode;
}
