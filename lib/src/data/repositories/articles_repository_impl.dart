import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter_news_app/src/core/params/article_request.dart';
import 'package:flutter_news_app/src/core/resources/data_state.dart';
import 'package:flutter_news_app/src/data/datasources/local/app_database.dart';
import 'package:flutter_news_app/src/domain/entities/article.dart';
import 'package:flutter_news_app/src/domain/repositories/articles_repository.dart';
import 'package:flutter_news_app/src/data/datasources/remote/news_api_service.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  const ArticlesRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticles(
    ArticlesRequestParams params,
  ) async {
    try {
      final httpResponse = await _newsApiService.getBreakingNewsArticles(
        apiKey: params.apiKey,
        country: params.country,
        category: params.category,
        page: params.page,
        pageSize: params.pageSize,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> removeArticle(Article article) async {
    return _appDatabase.articleDao.deleteArticle(article);
  }

  @override
  Future<void> saveArticle(Article article) async {
    return _appDatabase.articleDao.insertArticle(article);
  }
}
