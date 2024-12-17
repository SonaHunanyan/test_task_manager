sealed class CommentsEvent {
  const CommentsEvent();
}

class CommentsEvent$Get extends CommentsEvent {
  const CommentsEvent$Get();
}

class CommentsEvent$Create extends CommentsEvent {
  const CommentsEvent$Create({
    required this.content,
  });
  final String content;
}

class CommentsEvent$Delete extends CommentsEvent {
  const CommentsEvent$Delete({required this.commentId});
  final String commentId;
}

class CommentsEvent$Update extends CommentsEvent {
  const CommentsEvent$Update({
    required this.commentId,
    required this.content,
  });
  final String commentId;
  final String content;
}
