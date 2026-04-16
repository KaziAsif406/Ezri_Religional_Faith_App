// To parse this JSON data, do
//
//     final productDetailsResModel = productDetailsResModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsResModel productDetailsResModelFromJson(String str) => ProductDetailsResModel.fromJson(json.decode(str));

String productDetailsResModelToJson(ProductDetailsResModel data) => json.encode(data.toJson());

class ProductDetailsResModel {
    bool? success;
    String? message;
    Data? data;

    ProductDetailsResModel({
        this.success,
        this.message,
        this.data,
    });

    factory ProductDetailsResModel.fromJson(Map<String, dynamic> json) => ProductDetailsResModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Product? product;

    Data({
        this.product,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
    };
}

class Product {
    int? id;
    String? name;
    String? price;
    String? regularPrice;
    String? salePrice;
    bool? onSale;
    String? image;
    String? rating;
    int? reviewCount;
    String? stockStatus;
    bool? inStock;
    String? description;
    String? shortDescription;
    String? sku;
    String? type;
    List<dynamic>? attributes;
    List<dynamic>? galleryImages;
    List<Category>? categories;
    List<dynamic>? variations;

    Product({
        this.id,
        this.name,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.onSale,
        this.image,
        this.rating,
        this.reviewCount,
        this.stockStatus,
        this.inStock,
        this.description,
        this.shortDescription,
        this.sku,
        this.type,
        this.attributes,
        this.galleryImages,
        this.categories,
        this.variations,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        onSale: json["on_sale"],
        image: json["image"],
        rating: json["rating"],
        reviewCount: json["review_count"],
        stockStatus: json["stock_status"],
        inStock: json["in_stock"],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        type: json["type"],
        attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        galleryImages: json["gallery_images"] == null ? [] : List<dynamic>.from(json["gallery_images"]!.map((x) => x)),
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "on_sale": onSale,
        "image": image,
        "rating": rating,
        "review_count": reviewCount,
        "stock_status": stockStatus,
        "in_stock": inStock,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "type": type,
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
        "gallery_images": galleryImages == null ? [] : List<dynamic>.from(galleryImages!.map((x) => x)),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x)),
    };
}

class Category {
    int? id;
    String? name;
    String? slug;

    Category({
        this.id,
        this.name,
        this.slug,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}
