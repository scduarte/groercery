import 'dart:convert';

import 'package:flutter/foundation.dart';

import './product.dart';

class Groercery {
  final int id;
  final String name;
  final List<Product> products;

  const Groercery({
    required this.id,
    required this.name,
    required this.products,
  });

  Groercery copyWith({
    int? id,
    String? name,
    List<Product>? products,
  }) {
    return Groercery(
      id: id ?? this.id,
      name: name ?? this.name,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Groercery.fromMap(Map<String, dynamic> map) {
    return Groercery(
      id: map['id'] as int,
      name: map['name'] as String,
      products: List<Product>.from(
        (map['products']).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Groercery.fromJson(String source) =>
      Groercery.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Groercery(id: $id, name: $name, products: $products)';

  @override
  bool operator ==(covariant Groercery other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ products.hashCode;
}
