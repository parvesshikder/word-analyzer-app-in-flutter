import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var app = await Firebase.initializeApp();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(app: app, title: 'Flutter Demo')));
}

class MyHomePage extends StatefulWidget {
  final FirebaseApp app;

  const MyHomePage({Key? key, required this.title, required this.app})
      : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final refDataInstance = FirebaseDatabase.instance.reference().child('users');

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.04,
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Enter user name',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  name = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your password.',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    // adds new user to DB
                    refDataInstance.push().child('name').set(name).asStream();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add user')),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                  child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: refDataInstance,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return ListTile(
                    title: Text(snapshot.value.toString()),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
