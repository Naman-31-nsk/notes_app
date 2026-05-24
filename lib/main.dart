import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes App",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> notes = [];

  TextEditingController noteController = TextEditingController();

  void addNote() {
    if (noteController.text.isNotEmpty) {
      setState(() {
        notes.add(noteController.text);
      });

      noteController.clear();
    }
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Note"),

          content: TextField(
            controller: noteController,
            decoration: InputDecoration(hintText: "Enter your note"),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                addNote();

                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Notes"), centerTitle: true),

      body: notes.isEmpty
          ? Center(
              child: Text("No Notes Added", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: notes.length,

              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),

                  child: ListTile(
                    title: Text(notes[index]),

                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),

                      onPressed: () {
                        deleteNote(index);
                      },
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddNoteDialog();
        },

        child: Icon(Icons.add),
      ),
    );
  }
}
