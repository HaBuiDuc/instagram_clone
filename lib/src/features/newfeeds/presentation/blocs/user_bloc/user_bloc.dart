import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/common/use_case/get_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser _getUser;
  UserBloc(GetUser getUser)
      : _getUser = getUser,
        super(UserInitial()) {
    on<LoadingUserEvent>(_loadingUser);
  }

  void _loadingUser(LoadingUserEvent event, Emitter emit) async {
    emit(UserLoading());
    final res = await _getUser(event.userId);
    res.fold(
      (l) => emit(UserLoadedFailure(failure: l)),
      (r) => emit(
        UserLoaded(userEntity: r),
      ),
    );
  }
}
