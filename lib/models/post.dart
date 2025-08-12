class Post {
  final String? id; // Firestore auto-generates IDs
  final String title;
  final String content;

  Post({this.id, required this.title, required this.content});

  // Convert Post to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }

  // Convert Firestore Document to Post
  factory Post.fromMap(String id, Map<String, dynamic> map) {
    return Post(id: id, title: map['title'], content: map['content']);
  }
}
