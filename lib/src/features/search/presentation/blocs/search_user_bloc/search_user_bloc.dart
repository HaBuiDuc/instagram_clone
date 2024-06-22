import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/search/domain/use_cases/search_user.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchUser _searchUser;
  SearchUserBloc(SearchUser searchUser)
      : _searchUser = searchUser,
        super(SearchUserInitial()) {
    on<SearchingUserEvent>(_searchUserEvent);
  }

  void _searchUserEvent(SearchingUserEvent event, Emitter emit) async {
    emit(UserSearchLoading());
    final res = await _searchUser(event.query);
    res.fold(
      (l) => emit(UserSearchFailure(failure: l)),
      (r) => emit(
        UserFound(userList: r),
      ),
    );
  }
}
