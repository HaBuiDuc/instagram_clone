import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/search/domain/repositories/search_repository.dart';

class SearchUser implements UseCase<List<UserEntity>, String> {
  final SearchRepository searchRepository;

  SearchUser({required this.searchRepository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(String params) async {
    return await searchRepository.searchUser(params);
  }
}
