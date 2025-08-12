import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CREATE: Add a new Post
  Future<void> addPost(Post post) async {
    await _firestore.collection('posts').add(post.toMap());
  }

  // READ: Get all Posts (Realtime Stream)
  Stream<List<Post>> getPosts() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  // UPDATE: Edit a Post
  Future<void> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.id).update(post.toMap());
  }

  // DELETE: Remove a Post
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}
