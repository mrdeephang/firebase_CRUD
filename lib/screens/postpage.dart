import 'package:firebase_crud/models/post.dart';
import 'package:firebase_crud/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // Show a Dialog for Adding/Editing Posts
  void _showPostDialog({Post? post}) {
    bool isEditing = post != null;
    _titleController.text = isEditing ? post.title : '';
    _contentController.text = isEditing ? post.content : '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Post' : 'Add Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Make the whole callback async
              if (_titleController.text.isEmpty ||
                  _contentController.text.isEmpty) {
                Fluttertoast.showToast(msg: 'Fields cannot be empty!');
                return;
              }

              try {
                if (isEditing) {
                  await _firestoreService.updatePost(
                    Post(
                      id: post.id,
                      title: _titleController.text,
                      content: _contentController.text,
                    ),
                  );
                  Fluttertoast.showToast(msg: 'Post updated!');
                } else {
                  await _firestoreService.addPost(
                    Post(
                      title: _titleController.text,
                      content: _contentController.text,
                    ),
                  );
                  Fluttertoast.showToast(msg: 'Post added!');
                }

                // Only pop if widget is still mounted
                // ignore: use_build_context_synchronously
                if (mounted) Navigator.pop(context);
              } catch (e) {
                if (mounted) Fluttertoast.showToast(msg: 'Error: $e');
              }
            },
            child: Text(isEditing ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'FIREBASE CRUD',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Post>>(
        stream: _firestoreService.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.content),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showPostDialog(post: post),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _firestoreService.deletePost(post.id!);
                        Fluttertoast.showToast(msg: 'Post deleted!');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPostDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

class Fontweight {}
