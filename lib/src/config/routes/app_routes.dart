import 'package:flutter/material.dart';

import 'package:flutter_news_app/src/domain/entities/article.dart';
import 'package:flutter_news_app/src/presentation/views/article_details_view.dart';
import 'package:flutter_news_app/src/presentation/views/breaking_news_view.dart';
import 'package:flutter_news_app/src/presentation/views/saved_articles_view.dart';

mixin AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const BreakingNewsView());
      case '/ArticleDetailsView':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as Article));
        break;

      case '/SavedArticlesView':
        return _materialRoute(const SavedArticlesView());
        break;
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
