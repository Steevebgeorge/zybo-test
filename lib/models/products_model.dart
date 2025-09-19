
class ProductModel {
  final int id;
  final List<dynamic> variations; // API gives an array; keep flexible
  final bool inWishlist;
  final double avgRating;
  final List<String> images;
  final bool variationExists;
  final double salePrice;
  final String name;
  final String description;
  final String caption;
  final String featuredImage;
  final double mrp;
  final int stock;
  final bool isActive;
  final String discount;
  final DateTime? createdDate;
  final String productType;
  final int? showingOrder;
  final String variationName;
  final int? category; // in your product JSON this is an integer
  final double taxRate;

  ProductModel({
    required this.id,
    required this.variations,
    required this.inWishlist,
    required this.avgRating,
    required this.images,
    required this.variationExists,
    required this.salePrice,
    required this.name,
    required this.description,
    required this.caption,
    required this.featuredImage,
    required this.mrp,
    required this.stock,
    required this.isActive,
    required this.discount,
    required this.createdDate,
    required this.productType,
    required this.showingOrder,
    required this.variationName,
    required this.category,
    required this.taxRate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // helper to safely parse numbers that might be int or double or null
    double toDouble(dynamic x) {
      if (x == null) return 0.0;
      if (x is double) return x;
      if (x is int) return x.toDouble();
      if (x is String) {
        return double.tryParse(x) ?? 0.0;
      }
      return 0.0;
    }

    int? toInt(dynamic x) {
      if (x == null) return null;
      if (x is int) return x;
      if (x is double) return x.toInt();
      if (x is String) return int.tryParse(x);
      return null;
    }

    DateTime? parsedDate;
    if (json['created_date'] != null) {
      try {
        parsedDate = DateTime.parse(json['created_date']);
      } catch (e) {
        parsedDate = null;
      }
    }

    // parse images list (ensure strings)
    List<String> imagesList = [];
    if (json['images'] != null && json['images'] is List) {
      imagesList =
          (json['images'] as List).map((e) => e?.toString() ?? '').toList();
    }

    return ProductModel(
      id: json['id'] ?? 0,
      variations: json['variations'] != null
          ? List<dynamic>.from(json['variations'])
          : <dynamic>[],
      inWishlist: json['in_wishlist'] == true,
      avgRating: toDouble(json['avg_rating']),
      images: imagesList,
      variationExists: json['variation_exists'] == true,
      salePrice: toDouble(json['sale_price']),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      caption: json['caption']?.toString() ?? '',
      featuredImage: json['featured_image']?.toString() ?? '',
      mrp: toDouble(json['mrp']),
      stock: toInt(json['stock']) ?? 0,
      isActive: json['is_active'] == true,
      discount: json['discount']?.toString() ?? '0',
      createdDate: parsedDate,
      productType: json['product_type']?.toString() ?? '',
      showingOrder: toInt(json['showing_order']),
      variationName: json['variation_name']?.toString() ?? '',
      category: toInt(json['category']),
      taxRate: toDouble(json['tax_rate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variations': variations,
      'in_wishlist': inWishlist,
      'avg_rating': avgRating,
      'images': images,
      'variation_exists': variationExists,
      'sale_price': salePrice,
      'name': name,
      'description': description,
      'caption': caption,
      'featured_image': featuredImage,
      'mrp': mrp,
      'stock': stock,
      'is_active': isActive,
      'discount': discount,
      'created_date': createdDate?.toIso8601String(),
      'product_type': productType,
      'showing_order': showingOrder,
      'variation_name': variationName,
      'category': category,
      'tax_rate': taxRate,
    };
  }
}

// to fetch details of products