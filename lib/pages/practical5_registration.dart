import 'package:flutter/material.dart';

/// Practical 5: Student Records App (CRUD)

/// Data model for Student
class Student {
  final String id;
  String name;
  Student({required this.id, required this.name});
}

class Practical5StudentRecordsApp extends StatefulWidget {
  const Practical5StudentRecordsApp({super.key});

  @override
  State<Practical5StudentRecordsApp> createState() =>
      _Practical5StudentRecordsAppState();
}

class _Practical5StudentRecordsAppState
    extends State<Practical5StudentRecordsApp> {
  final List<Student> _students = <Student>[
    Student(id: 'S001', name: 'John Doe'),
    Student(id: 'S002', name: 'Jane Smith'),
    Student(id: 'S003', name: 'Peter Jones'),
  ];
  final TextEditingController _nameController = TextEditingController();

  void _addStudent() {
    _nameController.clear();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Student'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Student Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  setState(() {
                    _students.add(
                      Student(
                        id: 'S${_students.length + 1}',
                        name: _nameController.text,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _editStudent(int index) {
    _nameController.text = _students[index].name;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Student Name'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Student Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  setState(() {
                    _students[index].name = _nameController.text;
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(int index) {
    setState(() {
      _students.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Practical 5: Student Records App',
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _addStudent,
              icon: const Icon(Icons.add),
              label: const Text('Add New Student'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (BuildContext context, int index) {
                final Student student = _students[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(student.id)),
                  title: Text(student.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editStudent(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStudent(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
