// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../utils/constants.dart';

class Product {
  final String title;
  final String subTitle;
  String? image;
  final ProductType productType;
  Product({
    required this.title,
    required this.subTitle,
    this.image,
    required this.productType,
  });

  Product copyWith({
    String? title,
    String? subTitle,
    String? image,
    ProductType? productType,
  }) {
    return Product(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      image: image ?? this.image,
      productType: productType ?? this.productType,
    );
  }

  @override
  String toString() {
    return 'Product(title: $title, subTitle: $subTitle, image: $image, productType: $productType)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.title == title && other.subTitle == subTitle && other.image == image && other.productType == productType;
  }

  @override
  int get hashCode {
    return title.hashCode ^ subTitle.hashCode ^ image.hashCode ^ productType.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subTitle': subTitle,
      'image': image,
      'productType': productType.index,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      productType: ProductType.values[map['productType']],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
