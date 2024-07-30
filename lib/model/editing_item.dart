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
  Color? color;
  Product? product;
  final EditItemType type;
  int? selectedButtonShapeIndex;
  int? textBackgroundColorIndex;
  Size? textSize;

  EditItem({
    required this.key,
    required this.type,
    required this.position,
    required this.text,
    required this.fontSize,
    required this.fontFamily,
    this.textAlign,
    this.color,
    this.selectedButtonShapeIndex,
    this.product,
    this.textBackgroundColorIndex,
    this.textSize,
  });

  EditItem copyWith({
    GlobalKey? key,
    EditItemType? type,
    Offset? position,
    String? text,
    double? fontSize,
    TextAlign? textAlign,
    Color? color,
    String? fontFamily,
    int? selectedButtonShapeIndex,
    Product? product,
    int? textBackgroundColorIndex,
    Size? textSize,
  }) {
    return EditItem(
      key: key ?? this.key,
      type: type ?? this.type,
      position: position ?? this.position,
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      textAlign: textAlign ?? this.textAlign,
      color: color ?? this.color,
      product: product ?? this.product,
      selectedButtonShapeIndex: selectedButtonShapeIndex ?? this.selectedButtonShapeIndex,
      textBackgroundColorIndex: textBackgroundColorIndex ?? this.textBackgroundColorIndex,
      textSize: textSize ?? this.textSize,
    );
  }
}
