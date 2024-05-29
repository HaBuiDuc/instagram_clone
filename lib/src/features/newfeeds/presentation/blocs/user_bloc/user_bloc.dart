import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/user_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/use_cases/get_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser _getUser;
  UserBloc(GetUser getUser)
      : _getUser = getUser,
        super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<LoadingUserEvent>(_loadingUser);
  }

  void _loadingUser(LoadingUserEvent event, Emitter emit) async {
    final res = await _getUser(event.userId);
    res.fold(
      (l) => emit(UserLoadedFailure(failure: l)),
      (r) => emit(
        UserLoaded(userEntity: r),
      ),
    );
  }
}
