import 'package:flutter/material.dart';
import 'pages/practical1_navigation.dart';
import 'pages/practical2_temperature.dart';
import 'pages/practical3_todo.dart';
import 'pages/practical4_student_records.dart';
import 'pages/practical5_registration.dart';
import 'pages/practical6_notes.dart';
import 'pages/practical7_product_catalog.dart';
import 'pages/practical8_api_data.dart';
import 'pages/practical9_login_auth.dart';
import 'pages/practical10_deployment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, dynamic>> practicals = [
    {'title': 'Practical 1: Navigation', 'widget': Practical1Navigation()},
    {'title': 'Practical 2: Temperature', 'widget': Practical2Temperature()},
    {'title': 'Practical 3: Todo', 'widget': Practical3Todo()},
    {'title': 'Practical 4: Student Records', 'widget': Practical4StudentRecords()},
    {'title': 'Practical 5: Registration', 'widget': Practical5StudentRecordsApp()},
    {'title': 'Practical 6: Notes', 'widget': Practical6Notes()},
    {'title': 'Practical 7: Product Catalog', 'widget': Practical7ProductCatalog()},
    {'title': 'Practical 8: API Data', 'widget': Practical8ApiDataApp()},
    {'title': 'Practical 9: Login Auth', 'widget': Practical9LoginAuth()},
    {'title': 'Practical 10: Deployment', 'widget': Practical10DeploymentInfo()},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practicals Menu',
      home: Scaffold(
        appBar: AppBar(title: Text('All Practicals')),
        body: ListView.builder(
          itemCount: practicals.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(practicals[index]['title']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => practicals[index]['widget'],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}