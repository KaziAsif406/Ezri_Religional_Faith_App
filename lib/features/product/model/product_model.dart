// To parse this JSON data, do
//
//     final productsResponse = productsResponseFromJson(jsonString);

import 'dart:convert';

ProductsResponse productsResponseFromJson(String str) => ProductsResponse.fromJson(json.decode(str));

String productsResponseToJson(ProductsResponse data) => json.encode(data.toJson());

class ProductsResponse {
    bool? success;
    String? message;
    Data? data;

    ProductsResponse({
        this.success,
        this.message,
        this.data,
    });

    factory ProductsResponse.fromJson(Map<String, dynamic> json) => ProductsResponse(
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
    List<ProductModel>? products;
    PaginationModel? pagination;

    Data({
        this.products,
        this.pagination,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: json["products"] == null ? [] : List<ProductModel>.from(json["products"]!.map((x) => ProductModel.fromJson(x))),
        pagination: json["pagination"] == null ? null : PaginationModel.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class PaginationModel {
    int? currentPage;
    int? perPage;
    int? totalProducts;
    int? totalPages;
    bool? hasNext;
    bool? hasPrev;

    PaginationModel({
        this.currentPage,
        this.perPage,
        this.totalProducts,
        this.totalPages,
        this.hasNext,
        this.hasPrev,
    });

    factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalProducts: json["total_products"],
        totalPages: json["total_pages"],
        hasNext: json["has_next"],
        hasPrev: json["has_prev"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "per_page": perPage,
        "total_products": totalProducts,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_prev": hasPrev,
    };
}

class ProductModel {
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

    ProductModel({
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
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
    };
}
