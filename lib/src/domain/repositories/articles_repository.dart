import 'package:flutter_news_app/src/core/params/article_request.dart';
import 'package:flutter_news_app/src/core/resources/data_state.dart';
import 'package:flutter_news_app/src/domain/entities/article.dart';

abstract class ArticlesRepository {
  Future<DataState<List<Article>>> getBreakingNewsArticles(
      ArticlesRequestParams params);
  // Database methods
  Future<List<Article>> getSavedArticles();

  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article);
}
