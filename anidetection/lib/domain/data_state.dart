part of "data_cubit.dart";

abstract class DataState extends Equatable{}

@immutable
class EmptyDataState extends DataState {
  @override
  List<Object?> get props => [];
}

@immutable
class DirectoryDataState extends DataState {
  final MyTreeNode rootNode;

  DirectoryDataState(this.rootNode);

  @override
  List<Object?> get props => [rootNode];
}

@immutable
class CsvDataState extends DataState {
  final String csvData;
  final String rootFolder;

  CsvDataState({required this.csvData, required this.rootFolder});

  @override
  List<Object?> get props => [csvData];
}

@immutable
class LoadingDataState extends DataState {
  @override
  List<Object?> get props => [];
}

@immutable
class ErrorDataState extends DataState {
  final String? message;

  ErrorDataState(this.message);

  @override
  List<Object?> get props => [message];
}
