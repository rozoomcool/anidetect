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
class LoadedDataState extends DataState {
  final List<DataRowDefault> data;
  final String rootFolder;

  LoadedDataState({required this.data, required this.rootFolder});

  @override
  List<Object?> get props => [data];
}

@immutable
class LoadedSubmissionDataState extends DataState {
  final List<SampleSubmissionData> data;

  LoadedSubmissionDataState({required this.data});

  @override
  List<Object?> get props => [data];
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
