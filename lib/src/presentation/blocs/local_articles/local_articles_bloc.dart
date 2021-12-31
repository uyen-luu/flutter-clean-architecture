import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_news_app/src/domain/entities/article.dart';
import 'package:flutter_news_app/src/domain/usecaes/get_saved_articles_usecase.dart';
import 'package:flutter_news_app/src/domain/usecaes/remove_article_usecase.dart';
import 'package:flutter_news_app/src/domain/usecaes/save_article_usecase.dart';

part 'local_articles_event.dart';
part 'local_articles_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  ) : super(const LocalArticlesLoading()) {
    on<GetAllSavedArticles>(_getAllSavedArticles);
    on<RemoveArticle>((event, emit) async {
      await _removeArticleUseCase(params: event.article);
      await _getAllSavedArticles(event, emit);
    });
    on<SaveArticle>((event, emit) async {
      await _saveArticleUseCase(params: event.article);
      await _getAllSavedArticles(event, emit);
    });
  }

  FutureOr<void> _getAllSavedArticles(
      LocalArticlesEvent event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticlesDone(articles));
  }
}
