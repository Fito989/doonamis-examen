import 'package:doonamis_examen/constants/map_keys/map_keys.dart';
import 'package:doonamis_examen/models/creator.dart';

class Serie {
  int id;
  String? name;
  String? overview;
  String? posterPath;
  String? firstAirDate;
  String? lastAirDate;
  String? nextEpisodeAirDate;
  double? voteAverage;
  int? voteCount;
  bool? inProduction;
  List<Creator>? creators;

  Serie({required this.id, this.name, this.overview, this.posterPath, this.firstAirDate, this.lastAirDate, this.nextEpisodeAirDate, this.voteAverage, this.voteCount, this.inProduction, this.creators});

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
      MapKeys.body.in_production: inProduction,
      MapKeys.body.created_by: creators,
    };
  }
}
