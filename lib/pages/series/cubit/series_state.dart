part of 'series_cubit.dart';

class SeriesState extends Equatable {
  final PageStatusEnum? pageStatus;
  final int? page;
  final int? totalPages;
  final List<Serie>? serieList;

  const SeriesState({this.pageStatus, this.serieList, this.totalPages, this.page});

  SeriesState copyWithProps(
      {PageStatusEnum? pageStatus,
      int? page,
      int? totalPages,
      List<Serie>? serieList}) {
    return SeriesState(
        pageStatus: pageStatus ?? this.pageStatus,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        serieList: serieList ?? this.serieList
    );
  }

  @override
  List<dynamic> get props => [pageStatus, serieList, page, totalPages];
}
