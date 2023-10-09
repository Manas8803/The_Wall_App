import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall_app/components/wall_post.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': FieldValue.serverTimestamp(),
        'Likes': [],
      });
    }

    setState(() {
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.indigo[600],
        title: const Text(
          "THE WALL APP",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Posts")
                  .orderBy("TimeStamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No Posts available.'),
                  );
                }

                final postDocs = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: postDocs.length,
                    itemBuilder: (context, index) {
                      final post = postDocs[index].data();
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 2.0), // Adjust margin as needed
                        child: WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: postDocs[index].id,
                          likes: List<String>.from(post['Likes'] ?? []),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 3.0),
                        ),
                        hintText: "Share your thoughts, one word at a time...",
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: postMessage,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo,
                    ),
                    child: const Icon(
                      Icons.arrow_circle_up_sharp,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
