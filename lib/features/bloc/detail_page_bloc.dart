import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_page_event.dart';
part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  DetailPageBloc(List<String> initialComments) : super(DetailPageState(comments: initialComments)) {
    on<AddCommentEvent>(_onAddComment);
  }

  void _onAddComment(AddCommentEvent event, Emitter<DetailPageState> emit) {
    final updatedComments = List<String>.from(state.comments)..add(event.comment);
    emit(DetailPageState(comments: updatedComments));
  }
}
