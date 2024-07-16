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
      productType: productType ?? this.productType,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      image: image ?? this.image,
    );
  }

  @override
  String toString() => 'Product(productType: $productType, title: $title, subTitle: $subTitle, image: $image)';

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.productType == productType && other.title == title && other.subTitle == subTitle && other.image == image;
  }

  @override
  int get hashCode => productType.hashCode ^ title.hashCode ^ subTitle.hashCode ^ image.hashCode;
}
