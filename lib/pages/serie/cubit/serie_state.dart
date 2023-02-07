part of 'serie_cubit.dart';

class SerieState extends Equatable {
  final PageStatusEnum? pageStatus;
  final Serie? serie;

  const SerieState({this.pageStatus, this.serie});

  SerieState copyWithProps(
      {PageStatusEnum? pageStatus,
      Serie? serie,
      TextEditingController? nameInput}) {
    return SerieState(
        pageStatus: pageStatus ?? this.pageStatus,
        serie: serie ?? this.serie,
    );
  }

  @override
  List<dynamic> get props => [pageStatus, serie];
}
