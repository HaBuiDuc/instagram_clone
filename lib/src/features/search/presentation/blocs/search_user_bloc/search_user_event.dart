part of 'search_user_bloc.dart';

sealed class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

final class SearchingUserEvent extends SearchUserEvent {
  final String query;

  const SearchingUserEvent({required this.query});
}