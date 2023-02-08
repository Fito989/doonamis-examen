// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SerieDao? _serieDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Serie` (`id` INTEGER NOT NULL, `name` TEXT, `overview` TEXT, `posterPath` TEXT, `firstAirDate` TEXT, `lastAirDate` TEXT, `nextEpisodeAirDate` TEXT, `voteAverage` REAL, `voteCount` INTEGER, `page` INTEGER, `inProduction` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SerieDao get serieDao {
    return _serieDaoInstance ??= _$SerieDao(database, changeListener);
  }
}

class _$SerieDao extends SerieDao {
  _$SerieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _serieInsertionAdapter = InsertionAdapter(
            database,
            'Serie',
            (Serie item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'firstAirDate': item.firstAirDate,
                  'lastAirDate': item.lastAirDate,
                  'nextEpisodeAirDate': item.nextEpisodeAirDate,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'page': item.page,
                  'inProduction': item.inProduction == null
                      ? null
                      : (item.inProduction! ? 1 : 0)
                },
            changeListener),
        _serieUpdateAdapter = UpdateAdapter(
            database,
            'Serie',
            ['id'],
            (Serie item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'firstAirDate': item.firstAirDate,
                  'lastAirDate': item.lastAirDate,
                  'nextEpisodeAirDate': item.nextEpisodeAirDate,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'page': item.page,
                  'inProduction': item.inProduction == null
                      ? null
                      : (item.inProduction! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Serie> _serieInsertionAdapter;

  final UpdateAdapter<Serie> _serieUpdateAdapter;

  @override
  Future<List<Serie>> findAllSeries() async {
    return _queryAdapter.queryList('SELECT * FROM Serie',
        mapper: (Map<String, Object?> row) => Serie(
            id: row['id'] as int,
            name: row['name'] as String?,
            overview: row['overview'] as String?,
            posterPath: row['posterPath'] as String?,
            firstAirDate: row['firstAirDate'] as String?,
            lastAirDate: row['lastAirDate'] as String?,
            nextEpisodeAirDate: row['nextEpisodeAirDate'] as String?,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?,
            page: row['page'] as int?,
            inProduction: row['inProduction'] == null
                ? null
                : (row['inProduction'] as int) != 0));
  }

  @override
  Future<List<Serie>> findAllSeriesByPage(int page) async {
    return _queryAdapter.queryList('SELECT * FROM Serie WHERE page = ?1',
        mapper: (Map<String, Object?> row) => Serie(
            id: row['id'] as int,
            name: row['name'] as String?,
            overview: row['overview'] as String?,
            posterPath: row['posterPath'] as String?,
            firstAirDate: row['firstAirDate'] as String?,
            lastAirDate: row['lastAirDate'] as String?,
            nextEpisodeAirDate: row['nextEpisodeAirDate'] as String?,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?,
            page: row['page'] as int?,
            inProduction: row['inProduction'] == null
                ? null
                : (row['inProduction'] as int) != 0),
        arguments: [page]);
  }

  @override
  Stream<Serie?> findSerieById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Serie WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Serie(
            id: row['id'] as int,
            name: row['name'] as String?,
            overview: row['overview'] as String?,
            posterPath: row['posterPath'] as String?,
            firstAirDate: row['firstAirDate'] as String?,
            lastAirDate: row['lastAirDate'] as String?,
            nextEpisodeAirDate: row['nextEpisodeAirDate'] as String?,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?,
            page: row['page'] as int?,
            inProduction: row['inProduction'] == null
                ? null
                : (row['inProduction'] as int) != 0),
        arguments: [id],
        queryableName: 'Serie',
        isView: false);
  }

  @override
  Future<void> insertSerie(Serie serie) async {
    await _serieInsertionAdapter.insert(serie, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSerie(Serie serie) async {
    await _serieUpdateAdapter.update(serie, OnConflictStrategy.abort);
  }
}
