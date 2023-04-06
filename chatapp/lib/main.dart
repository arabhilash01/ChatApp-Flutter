import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(snapshot.data[index].displayName),
                );
              },
            );
          },
          future: getContacts(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future getContacts() async {
  print('getting contact');
  PermissionStatus status = await Permission.contacts.status;
  if (status.isGranted) {
    // Permission is already granted, retrieve contacts
    List<Contact> contacts = await ContactsService.getContacts();
    // Do something with the contacts list
  } else {
    // Permission is not granted, request it from the user
    status = await Permission.contacts.request();
    if (status.isGranted) {
      // Permission granted, retrieve contacts
      List<Contact> contacts = await ContactsService.getContacts();
      // Do something with the contacts list
    } else {
      // Permission denied, handle accordingly
      return null;
    }
  }
  List<Contact> contact = await ContactsService.getContacts();
  print('----------------------------');
  print(contact);
  return contact;
}
