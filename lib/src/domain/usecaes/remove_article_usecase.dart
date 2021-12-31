import 'package:flutter_news_app/src/core/usecase/usecase.dart';
import 'package:flutter_news_app/src/domain/entities/article.dart';
import 'package:flutter_news_app/src/domain/repositories/articles_repository.dart';

class RemoveArticleUseCase implements UseCase<void, Article> {
  final ArticlesRepository _articlesRepository;

  RemoveArticleUseCase(this._articlesRepository);

  @override
  Future<void> call({Article params}) {
    return _articlesRepository.removeArticle(params);
  }
}
