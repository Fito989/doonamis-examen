part of 'generic_cubit.dart';

class GenericState extends Equatable {
  final PageStatusEnum? pageStatus;
  final String? languageCode;
  final ThemeData? themeData;

  const GenericState({this.pageStatus, this.languageCode, this.themeData});

  GenericState copyWithProps(
      {PageStatusEnum? pageStatus,
      ThemeData? themeData,
      String? languageCode}) {
    return GenericState(
      pageStatus: pageStatus ?? this.pageStatus,
      languageCode: languageCode ?? this.languageCode,
      themeData: themeData ?? this.themeData,
    );
  }

  @override
  List<dynamic> get props => [pageStatus, languageCode, themeData];
}
