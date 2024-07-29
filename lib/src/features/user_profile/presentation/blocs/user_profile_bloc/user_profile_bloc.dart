import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/common/use_case/get_current_user.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/updating_user_data.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetCurrentUser _getCurrentUser;
  final UpdatingUserData _updatingUserData;
  UserProfileBloc(
      GetCurrentUser getCurrentUser, UpdatingUserData updatingUserData)
      : _getCurrentUser = getCurrentUser,
        _updatingUserData = updatingUserData,
        super(UserInitial()) {
    on<GetCurrentUserEvent>(_getUserEvent);
    on<UpdatingUserEvent>(_updatingUserEvent);
  }

  void _getUserEvent(GetCurrentUserEvent event, Emitter emit) async {
    final res = await _getCurrentUser(null);
    res.fold(
        (l) => emit(UserLoadFailed()), (r) => emit(UserLoaded(userEntity: r)));
  }

  void _updatingUserEvent(UpdatingUserEvent event, Emitter emit) async {
    final res = await _updatingUserData(UpdatingUserParams(
      email: event.email,
      username: event.username,
      fullName: event.fullName,
      avatarUrl: event.avatarUrl,
      bio: event.bio,
      followers: event.followers,
      following: event.following,
      posts: event.posts,
    ));
    res.fold((l) => emit(UserLoadFailed()), (r) {
      emit(UserUpdated());
      add(GetCurrentUserEvent());
    });
  }
}
