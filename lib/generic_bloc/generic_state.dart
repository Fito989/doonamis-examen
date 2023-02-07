part of 'generic_cubit.dart';

class GenericState extends Equatable {
  final PageStatusEnum? pageStatus;
  final String? languageCode;

  const GenericState({this.pageStatus, this.languageCode});

  GenericState copyWithProps(
      {PageStatusEnum? pageStatus,
      String? languageCode}) {
    return GenericState(
      pageStatus: pageStatus ?? this.pageStatus,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<dynamic> get props => [pageStatus, languageCode];
}
