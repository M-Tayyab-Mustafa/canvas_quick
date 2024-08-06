// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'product.dart';

class EditItem {
  GlobalKey key;
  Offset position;
  String text;
  double fontSize;
  String fontFamily;
  TextAlign? textAlign;
  Color? textColor;
  Color? backgroundColor;
  Product? product;
  final EditItemType type;
  int? selectedButtonShapeIndex;
  int? textBackgroundColorIndex;
  Size? size;

  EditItem({
    required this.key,
    required this.type,
    required this.position,
    required this.text,
    required this.fontSize,
    required this.fontFamily,
    this.backgroundColor,
    this.textAlign,
    this.textColor,
    this.selectedButtonShapeIndex,
    this.product,
    this.textBackgroundColorIndex,
    this.size,
  });

  EditItem copyWith({
    GlobalKey? key,
    EditItemType? type,
    Offset? position,
    String? text,
    double? fontSize,
    TextAlign? textAlign,
    Color? textColor,
    Color? backgroundColor,
    String? fontFamily,
    int? selectedButtonShapeIndex,
    Product? product,
    int? textBackgroundColorIndex,
    Size? size,
  }) {
    return EditItem(
      key: key ?? this.key,
      type: type ?? this.type,
      position: position ?? this.position,
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      textAlign: textAlign ?? this.textAlign,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      product: product ?? this.product,
      selectedButtonShapeIndex: selectedButtonShapeIndex ?? this.selectedButtonShapeIndex,
      textBackgroundColorIndex: textBackgroundColorIndex ?? this.textBackgroundColorIndex,
      size: size ?? this.size,
    );
  }
}
