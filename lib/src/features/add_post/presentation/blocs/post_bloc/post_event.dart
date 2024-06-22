part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class AddingPostEvent extends PostEvent {
  final String caption;
  final List<String> content;

  const AddingPostEvent({
    required this.caption,
    required this.content,
  });
}
