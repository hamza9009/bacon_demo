part of 'detail_page_bloc.dart';

class DetailPageState extends Equatable {
  final List<String> comments;

  DetailPageState({required this.comments});

  @override
  List<Object> get props => [comments];
}
