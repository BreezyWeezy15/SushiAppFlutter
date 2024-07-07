

import 'package:drift/drift.dart';
import 'package:sushi_restaurant/db/product_list_converter.dart';

class Sushi extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get image => text()();
  IntColumn get quantity => integer()();
  RealColumn get total => real()();
  RealColumn get price => real()();
  TextColumn get additionalInfo => text().nullable().map(const ProductListConverter())();

}