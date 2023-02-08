import 'dart:async';
import 'package:doonamis_examen/database/dao/serie_dao.dart';
import 'package:doonamis_examen/models/serie.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Serie])
abstract class AppDatabase extends FloorDatabase {
  SerieDao get serieDao;
}