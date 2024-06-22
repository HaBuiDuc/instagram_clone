abstract interface class PostRepository {
  Future<void> addPost(String caption, List<String> content);
}
