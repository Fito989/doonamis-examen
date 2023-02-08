import 'package:doonamis_examen/constants/map_keys/map_keys.dart';
import 'package:floor/floor.dart';

@entity
class Serie {
  @primaryKey
  int id;
  String? name;
  String? overview;
  String? posterPath;
  String? firstAirDate;
  String? lastAirDate;
  String? nextEpisodeAirDate;
  double? voteAverage;
  int? voteCount;
  int? page;
  bool? inProduction;

  Serie(
      {required this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.firstAirDate,
      this.lastAirDate,
      this.nextEpisodeAirDate,
      this.voteAverage,
      this.voteCount,
      this.page,
      this.inProduction});

  Serie copyWithPage({
    required int id,
    required String? name,
    required String? overview,
    required String? posterPath,
    required String? firstAirDate,
    required String? lastAirDate,
    required String? nextEpisodeAirDate,
    required double? voteAverage,
    required int? voteCount,
    required bool? inProduction,
  }) {
    return Serie(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        firstAirDate: firstAirDate,
        lastAirDate: lastAirDate,
        nextEpisodeAirDate: nextEpisodeAirDate,
        voteAverage: voteAverage,
        voteCount: voteCount,
        page: page,
        inProduction: inProduction);
  }

  Map<String, dynamic> toMap() {
    return {
      MapKeys.body.id: id,
      MapKeys.body.name: name,
      MapKeys.body.overview: overview,
      MapKeys.body.poster_path: posterPath,
      MapKeys.body.first_air_date: firstAirDate,
      MapKeys.body.last_air_date: lastAirDate,
      MapKeys.body.next_episode_to_air: nextEpisodeAirDate,
      MapKeys.body.vote_average: voteAverage,
      MapKeys.body.vote_count: voteCount,
      MapKeys.body.page: page,
      MapKeys.body.in_production: inProduction,
    };
  }
}
