part of 'content_cubit.dart';

abstract class ContentState extends Equatable {
  @override
  List<Object> get props => [];
}

class ContentLoading extends ContentState {}

class ContentData extends ContentState {
  final String message;

  ContentData(this.message);

  @override
  List<Object> get props => [message];
}

class ContentError extends ContentState {
  final String message;

  ContentError(this.message);

  @override
  List<Object> get props => [message];
}
