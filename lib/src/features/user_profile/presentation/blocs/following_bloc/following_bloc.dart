import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/add_following.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/check_following.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/unfollow.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  final CheckFollowing _checkFollowing;
  final AddFollowing _addFollowing;
  final Unfollow _unfollow;
  FollowingBloc(
    CheckFollowing checkFollowing,
    AddFollowing addFollowing,
    Unfollow unfollow,
  )   : _checkFollowing = checkFollowing,
        _addFollowing = addFollowing,
        _unfollow = unfollow,
        super(FollowingInitial()) {
    on<CheckingFollowEvent>(_checkingFollowEvent);
    on<AddingFollowEvent>(_addingFollowEvent);
    on<UnfollowEvent>(_unfollowEvent);
  }

  void _addingFollowEvent(AddingFollowEvent event, Emitter emit) async {
    final res = await _addFollowing(event.followed);
    res.fold(
      (l) => emit(FollowingFailure(failure: l)),
      (r) => emit(
        FollowingActionDone(),
      ),
    );
  }

  void _unfollowEvent(UnfollowEvent event, Emitter emit) async {
    final res = await _unfollow(event.followed);
    res.fold(
      (l) => emit(FollowingFailure(failure: l)),
      (r) => emit(
        FollowingActionDone(),
      ),
    );
  }

  void _checkingFollowEvent(CheckingFollowEvent event, Emitter emit) async {
    emit(FollowingLoading());
    final res = await _checkFollowing(event.followed);
    res.fold(
      (l) => emit(FollowingFailure(failure: l)),
      (r) => emit(
        FollowingChecked(result: r),
      ),
    );
  }
}
