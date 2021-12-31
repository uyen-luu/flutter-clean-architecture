import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_news_app/src/data/datasources/local/DAOs/articles_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:flutter_news_app/src/domain/entities/article.dart';
import 'converters/source_type_converter.dart';

part 'app_database.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [Article])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
