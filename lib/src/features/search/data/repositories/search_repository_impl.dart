import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/search/data/data_sources/search_data_source.dart';
import 'package:instagram_clone/src/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource searchDataSource;

  SearchRepositoryImpl({required this.searchDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> searchUser(String query) async {
    final res = await searchDataSource.searchUser(query);
    return right(res);
  }
}
