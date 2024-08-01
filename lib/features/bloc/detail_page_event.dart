part of 'detail_page_bloc.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();

  @override
  List<Object> get props => [];
}

class AddCommentEvent extends DetailPageEvent {
  final String comment;

  AddCommentEvent({required this.comment});

  @override
  List<Object> get props => [comment];
}
