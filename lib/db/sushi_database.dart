import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sushi_restaurant/db/sush_table.dart';
part 'sushi_database.g.dart';

@DriftDatabase(tables: [Sushi])
class SushiDatabase extends _$SushiDatabase {
  SushiDatabase._() : super(_openConnection());

  static final SushiDatabase instance = SushiDatabase._();

  @override
  int get schemaVersion => 1;

  Stream<List<SushiData>> getAllSushi() => select(sushi).watch();

  Future<List<SushiData>> getOrdersData() => select(sushi).get();

  // Insert Operation
  Future<int> insertSushi(SushiCompanion v) async {
    return await into(sushi).insert(v);
  }

  // Delete Operation
  Future<int> deleteSushi(int id) async {
    return await (delete(sushi)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Update Operation
  Future<int> updateSushi(int quantity, double totalPrice, int sushiID) async {
    return await (update(sushi)..where((tbl) => tbl.id.equals(sushiID))).write(
      SushiCompanion(
        quantity: Value(quantity),
        total: Value(totalPrice),
      ),
    );
  }

  // Delete All Operation
  Future<int> deleteAllSushi() async {
    return await delete(sushi).go();
  }

  Stream<double> sumTotal() {
    final sumQuery = customSelect(
      'SELECT SUM(total) AS totalSum FROM sushi;',
      readsFrom: {sushi},
    );

    final result = sumQuery.map((row) => row.readDouble('totalSum')).watchSingle();
    return result;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}
