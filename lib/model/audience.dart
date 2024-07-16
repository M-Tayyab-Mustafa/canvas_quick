// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class Audience {
  final String title;
  final String subTitle;
  final Icon icon;
  final Color backgroundColor;
  Audience({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.backgroundColor,
  });

  Audience copyWith({
    String? title,
    String? subTitle,
    Icon? icon,
    Color? backgroundColor,
  }) {
    return Audience(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  String toString() {
    return 'Audience(title: $title, subTitle: $subTitle, icon: $icon, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(covariant Audience other) {
    if (identical(this, other)) return true;

    return other.title == title && other.subTitle == subTitle && other.icon == icon && other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return title.hashCode ^ subTitle.hashCode ^ icon.hashCode ^ backgroundColor.hashCode;
  }
}
