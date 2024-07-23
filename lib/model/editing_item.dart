// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'product.dart';

class EditItem {
  GlobalKey key;
  Offset position;
  String? text;
  double? fontSize;
  TextAlign? textAlign;
  Color? color;
  String? fontFamily;
  final EditItemType type;
  int? selectedButtonShapeIndex;
  Product? product;
  bool? isTextBackgroundEnabled;
  Size? size;

  EditItem({
    required this.key,
    required this.type,
    required this.position,
    this.text,
    this.fontSize,
    this.textAlign,
    this.color,
    this.fontFamily,
    this.selectedButtonShapeIndex,
    this.product,
    this.isTextBackgroundEnabled,
    this.size,
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
    bool? isTextBackgroundEnabled,
    Size? size,
  }) {
    return EditItem(
        key: key ?? this.key,
        type: type ?? this.type,
        position: position ?? this.position,
        text: text ?? this.text,
        fontSize: fontSize ?? this.fontSize,
        textAlign: textAlign ?? this.textAlign,
        color: color ?? this.color,
        fontFamily: fontFamily ?? this.fontFamily,
        selectedButtonShapeIndex: selectedButtonShapeIndex ?? this.selectedButtonShapeIndex,
        product: product ?? this.product,
        isTextBackgroundEnabled: isTextBackgroundEnabled ?? this.isTextBackgroundEnabled,
        size: size ?? this.size);
  }

  @override
  String toString() {
    return 'EditItem(key: $key, itemType: $type, position: $position, text: $text, fontSize: $fontSize, textAlign: $textAlign, textColor: $color, fontFamily: $fontFamily, selectedButtonShapeIndex: $selectedButtonShapeIndex, product: $product, isTextBackgroundEnabled: $isTextBackgroundEnabled, size: $size)';
  }

  @override
  bool operator ==(covariant EditItem other) {
    if (identical(this, other)) return true;

    return other.key == key && other.type == type && other.position == position && other.text == text && other.fontSize == fontSize && other.textAlign == textAlign && other.color == color && other.fontFamily == fontFamily && other.selectedButtonShapeIndex == selectedButtonShapeIndex && other.product == product && other.isTextBackgroundEnabled == isTextBackgroundEnabled && other.size == size;
  }

  @override
  int get hashCode {
    return key.hashCode ^ type.hashCode ^ position.hashCode ^ text.hashCode ^ fontSize.hashCode ^ textAlign.hashCode ^ color.hashCode ^ fontFamily.hashCode ^ selectedButtonShapeIndex.hashCode ^ product.hashCode ^ isTextBackgroundEnabled.hashCode ^ size.hashCode;
  }
}
