import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bacon_demo/features/home/repo/article_repository.dart';
import 'package:bacon_demo/features/home/model/article.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _articleRepository;

  ArticleBloc(this._articleRepository) : super(ArticleInitial()) {
    on<FetchArticles>(_onFetchArticles);
  }

  void _onFetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    try {
      final articles = await _articleRepository.fetchArticles();
      emit(ArticleLoaded(articles: articles));
    } catch (e) {
      emit(ArticleError(message: e.toString()));
    }
  }
}
