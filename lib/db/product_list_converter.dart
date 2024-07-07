import 'dart:convert';
import 'package:drift/drift.dart';

import '../models/product.dart';

class ProductListConverter extends TypeConverter<List<Product>, String> {
  const ProductListConverter();

  @override
  List<Product> fromSql(String fromDb) {
    List<dynamic> jsonList = json.decode(fromDb);
    return jsonList.map((json) => Product.fromMap(json)).toList();
  }

  @override
  String toSql(List<Product> value) {
    List<Map<String, dynamic>> jsonList = value.map((product) => product.toMap()).toList();
    return json.encode(jsonList);
  }
}
