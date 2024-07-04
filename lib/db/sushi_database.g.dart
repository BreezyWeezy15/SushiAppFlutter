// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sushi_database.dart';

// ignore_for_file: type=lint
class $SushiTable extends Sushi with TableInfo<$SushiTable, SushiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SushiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _additionalInfoMeta =
      const VerificationMeta('additionalInfo');
  @override
  late final GeneratedColumn<String> additionalInfo = GeneratedColumn<String>(
      'additional_info', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, image, quantity, total, price, additionalInfo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sushi';
  @override
  VerificationContext validateIntegrity(Insertable<SushiData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('additional_info')) {
      context.handle(
          _additionalInfoMeta,
          additionalInfo.isAcceptableOrUnknown(
              data['additional_info']!, _additionalInfoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SushiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SushiData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      additionalInfo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}additional_info']),
    );
  }

  @override
  $SushiTable createAlias(String alias) {
    return $SushiTable(attachedDatabase, alias);
  }
}

class SushiData extends DataClass implements Insertable<SushiData> {
  final int id;
  final String title;
  final String description;
  final String image;
  final int quantity;
  final double total;
  final double price;
  final String? additionalInfo;
  const SushiData(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.quantity,
      required this.total,
      required this.price,
      this.additionalInfo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['image'] = Variable<String>(image);
    map['quantity'] = Variable<int>(quantity);
    map['total'] = Variable<double>(total);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || additionalInfo != null) {
      map['additional_info'] = Variable<String>(additionalInfo);
    }
    return map;
  }

  SushiCompanion toCompanion(bool nullToAbsent) {
    return SushiCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      image: Value(image),
      quantity: Value(quantity),
      total: Value(total),
      price: Value(price),
      additionalInfo: additionalInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(additionalInfo),
    );
  }

  factory SushiData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SushiData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      image: serializer.fromJson<String>(json['image']),
      quantity: serializer.fromJson<int>(json['quantity']),
      total: serializer.fromJson<double>(json['total']),
      price: serializer.fromJson<double>(json['price']),
      additionalInfo: serializer.fromJson<String?>(json['additionalInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'image': serializer.toJson<String>(image),
      'quantity': serializer.toJson<int>(quantity),
      'total': serializer.toJson<double>(total),
      'price': serializer.toJson<double>(price),
      'additionalInfo': serializer.toJson<String?>(additionalInfo),
    };
  }

  SushiData copyWith(
          {int? id,
          String? title,
          String? description,
          String? image,
          int? quantity,
          double? total,
          double? price,
          Value<String?> additionalInfo = const Value.absent()}) =>
      SushiData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        price: price ?? this.price,
        additionalInfo:
            additionalInfo.present ? additionalInfo.value : this.additionalInfo,
      );
  @override
  String toString() {
    return (StringBuffer('SushiData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('quantity: $quantity, ')
          ..write('total: $total, ')
          ..write('price: $price, ')
          ..write('additionalInfo: $additionalInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, description, image, quantity, total, price, additionalInfo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SushiData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.image == this.image &&
          other.quantity == this.quantity &&
          other.total == this.total &&
          other.price == this.price &&
          other.additionalInfo == this.additionalInfo);
}

class SushiCompanion extends UpdateCompanion<SushiData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> image;
  final Value<int> quantity;
  final Value<double> total;
  final Value<double> price;
  final Value<String?> additionalInfo;
  const SushiCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.quantity = const Value.absent(),
    this.total = const Value.absent(),
    this.price = const Value.absent(),
    this.additionalInfo = const Value.absent(),
  });
  SushiCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required String image,
    required int quantity,
    required double total,
    required double price,
    this.additionalInfo = const Value.absent(),
  })  : title = Value(title),
        description = Value(description),
        image = Value(image),
        quantity = Value(quantity),
        total = Value(total),
        price = Value(price);
  static Insertable<SushiData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? image,
    Expression<int>? quantity,
    Expression<double>? total,
    Expression<double>? price,
    Expression<String>? additionalInfo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (quantity != null) 'quantity': quantity,
      if (total != null) 'total': total,
      if (price != null) 'price': price,
      if (additionalInfo != null) 'additional_info': additionalInfo,
    });
  }

  SushiCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<String>? image,
      Value<int>? quantity,
      Value<double>? total,
      Value<double>? price,
      Value<String?>? additionalInfo}) {
    return SushiCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      price: price ?? this.price,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (additionalInfo.present) {
      map['additional_info'] = Variable<String>(additionalInfo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SushiCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('quantity: $quantity, ')
          ..write('total: $total, ')
          ..write('price: $price, ')
          ..write('additionalInfo: $additionalInfo')
          ..write(')'))
        .toString();
  }
}

abstract class _$SushiDatabase extends GeneratedDatabase {
  _$SushiDatabase(QueryExecutor e) : super(e);
  _$SushiDatabaseManager get managers => _$SushiDatabaseManager(this);
  late final $SushiTable sushi = $SushiTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sushi];
}

typedef $$SushiTableInsertCompanionBuilder = SushiCompanion Function({
  Value<int> id,
  required String title,
  required String description,
  required String image,
  required int quantity,
  required double total,
  required double price,
  Value<String?> additionalInfo,
});
typedef $$SushiTableUpdateCompanionBuilder = SushiCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> description,
  Value<String> image,
  Value<int> quantity,
  Value<double> total,
  Value<double> price,
  Value<String?> additionalInfo,
});

class $$SushiTableTableManager extends RootTableManager<
    _$SushiDatabase,
    $SushiTable,
    SushiData,
    $$SushiTableFilterComposer,
    $$SushiTableOrderingComposer,
    $$SushiTableProcessedTableManager,
    $$SushiTableInsertCompanionBuilder,
    $$SushiTableUpdateCompanionBuilder> {
  $$SushiTableTableManager(_$SushiDatabase db, $SushiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SushiTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SushiTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$SushiTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> image = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<String?> additionalInfo = const Value.absent(),
          }) =>
              SushiCompanion(
            id: id,
            title: title,
            description: description,
            image: image,
            quantity: quantity,
            total: total,
            price: price,
            additionalInfo: additionalInfo,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String description,
            required String image,
            required int quantity,
            required double total,
            required double price,
            Value<String?> additionalInfo = const Value.absent(),
          }) =>
              SushiCompanion.insert(
            id: id,
            title: title,
            description: description,
            image: image,
            quantity: quantity,
            total: total,
            price: price,
            additionalInfo: additionalInfo,
          ),
        ));
}

class $$SushiTableProcessedTableManager extends ProcessedTableManager<
    _$SushiDatabase,
    $SushiTable,
    SushiData,
    $$SushiTableFilterComposer,
    $$SushiTableOrderingComposer,
    $$SushiTableProcessedTableManager,
    $$SushiTableInsertCompanionBuilder,
    $$SushiTableUpdateCompanionBuilder> {
  $$SushiTableProcessedTableManager(super.$state);
}

class $$SushiTableFilterComposer
    extends FilterComposer<_$SushiDatabase, $SushiTable> {
  $$SushiTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get price => $state.composableBuilder(
      column: $state.table.price,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get additionalInfo => $state.composableBuilder(
      column: $state.table.additionalInfo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SushiTableOrderingComposer
    extends OrderingComposer<_$SushiDatabase, $SushiTable> {
  $$SushiTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get price => $state.composableBuilder(
      column: $state.table.price,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get additionalInfo => $state.composableBuilder(
      column: $state.table.additionalInfo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$SushiDatabaseManager {
  final _$SushiDatabase _db;
  _$SushiDatabaseManager(this._db);
  $$SushiTableTableManager get sushi =>
      $$SushiTableTableManager(_db, _db.sushi);
}
