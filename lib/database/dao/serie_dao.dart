import 'package:doonamis_examen/models/serie.dart';
import 'package:floor/floor.dart';

@dao
abstract class SerieDao {
  @Query('SELECT * FROM Serie')
  Future<List<Serie>> findAllSeries();

  @Query('SELECT * FROM Serie WHERE page = :page')
  Future<List<Serie>> findAllSeriesByPage(int page);

  @Query('SELECT * FROM Serie WHERE id = :id')
  Stream<Serie?> findSerieById(int id);

  @insert
  Future<void> insertSerie(Serie serie);

  @update
  Future<void> updateSerie(Serie serie);
}