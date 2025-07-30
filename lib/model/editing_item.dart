// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
    required this.position,
    required this.text,
    required this.fontSize,
    required this.fontFamily,
    this.textAlign,
    this.textColor,
    this.backgroundColor,
    this.product,
    required this.type,
    this.selectedButtonShapeIndex,
    this.textBackgroundColorIndex,
    this.size,
  });

  EditItem copyWith({
    GlobalKey? key,
    Offset? position,
    String? text,
    double? fontSize,
    String? fontFamily,
    TextAlign? textAlign,
    Color? textColor,
    Color? backgroundColor,
    Product? product,
    EditItemType? type,
    int? selectedButtonShapeIndex,
    int? textBackgroundColorIndex,
    Size? size,
  }) {
    return EditItem(
      key: key ?? this.key,
      position: position ?? this.position,
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      textAlign: textAlign ?? this.textAlign,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      product: product ?? this.product,
      type: type ?? this.type,
      selectedButtonShapeIndex: selectedButtonShapeIndex ?? this.selectedButtonShapeIndex,
      textBackgroundColorIndex: textBackgroundColorIndex ?? this.textBackgroundColorIndex,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key.toString(),
      'position': {'dx': position.dx, 'dy': position.dy},
      'text': text,
      'fontSize': fontSize,
      'fontFamily': fontFamily,
      'textAlign': textAlign?.index,
      'textColor': textColor?.value,
      'backgroundColor': backgroundColor?.value,
      'product': product?.toMap(),
      'type': type.index,
      'selectedButtonShapeIndex': selectedButtonShapeIndex,
      'textBackgroundColorIndex': textBackgroundColorIndex,
      'size': {'height': size?.height ?? 0, 'width': size?.width ?? 0},
    };
  }

  factory EditItem.fromMap(Map<String, dynamic> map) {
    return EditItem(
      key: GlobalKey(debugLabel: map['key']),
      position: Offset(map['position']['dx'], map['position']['dy']),
      text: map['text'] as String,
      fontSize: map['fontSize'] as double,
      fontFamily: map['fontFamily'] as String,
      textAlign: map['textAlign'] != null ? TextAlign.values[map['textAlign']] : null,
      textColor: map['textColor'] != null ? Color(map['textColor'] as int) : null,
      backgroundColor: map['backgroundColor'] != null ? Color(map['backgroundColor']) : null,
      product: map['product'] != null ? Product.fromMap(map['product']) : null,
      type: EditItemType.values[map['type']],
      selectedButtonShapeIndex: map['selectedButtonShapeIndex'] != null ? map['selectedButtonShapeIndex'] as int : null,
      textBackgroundColorIndex: map['textBackgroundColorIndex'] != null ? map['textBackgroundColorIndex'] as int : null,
      size: map['size'] != null ? Size(map['size']['width'], map['size']['height']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditItem.fromJson(String source) => EditItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EditItem(key: $key, position: $position, text: $text, fontSize: $fontSize, fontFamily: $fontFamily, textAlign: $textAlign, textColor: $textColor, backgroundColor: $backgroundColor, product: $product, type: $type, selectedButtonShapeIndex: $selectedButtonShapeIndex, textBackgroundColorIndex: $textBackgroundColorIndex, size: $size)';
  }

  @override
  bool operator ==(covariant EditItem other) {
    if (identical(this, other)) return true;

    return other.key == key &&
        other.position == position &&
        other.text == text &&
        other.fontSize == fontSize &&
        other.fontFamily == fontFamily &&
        other.textAlign == textAlign &&
        other.textColor == textColor &&
        other.backgroundColor == backgroundColor &&
        other.product == product &&
        other.type == type &&
        other.selectedButtonShapeIndex == selectedButtonShapeIndex &&
        other.textBackgroundColorIndex == textBackgroundColorIndex &&
        other.size == size;
  }

  @override
  int get hashCode {
    return key.hashCode ^ position.hashCode ^ text.hashCode ^ fontSize.hashCode ^ fontFamily.hashCode ^ textAlign.hashCode ^ textColor.hashCode ^ backgroundColor.hashCode ^ product.hashCode ^ type.hashCode ^ selectedButtonShapeIndex.hashCode ^ textBackgroundColorIndex.hashCode ^ size.hashCode;
  }
}
